/*==
== Copyright : BlueCurve (c)
== Licence   : Gnu/GPL v2.x
== Author    : Teddy Albina
== Email     : bluecurveteam@gmail.com
== Web site  : http://www.codeplex.com/BlueCurve
*/
using System;
using System.IO;
using System.Xml.Serialization;
using System.Text;
using System.Transactions;
using Microsoft.Win32.SafeHandles;
using System.Runtime.InteropServices;
using System.Runtime.Serialization.Formatters.Binary;

namespace BizTalk.Adapter.Atom
{
    /// <summary>
    /// Transactional file handling
    /// </summary>
    public class TransactionalFile
    {
        #region Import native methods

        /// <summary>
        /// Mthode native vrifiant si un rpertoire est vide
        /// </summary>
        /// <param name="pszPath">Chemin du rpertoire  tester</param>
        /// <returns>bool</returns>
        [DllImport("shlwapi.dll", CharSet = CharSet.Auto)]
        private extern static bool PathIsDirectoryEmpty(string pszPath);

        #region 'Kernel transaction manager api management'

        /// <summary>
        /// Transaction file handle
        /// </summary>
        public sealed class SafeTransactionHandle : SafeHandleZeroOrMinusOneIsInvalid
        {
            private SafeTransactionHandle()
                : base(true)
            {
            }

            public SafeTransactionHandle(IntPtr preexistingHandle, bool ownsHandle)
                : base(ownsHandle)
            {
                SetHandle(preexistingHandle);
            }

            public enum FileAccess
            {
                GENERIC_READ = unchecked((int)0x80000000),
                GENERIC_WRITE = 0x40000000
            }

            [Flags]
            public enum FileShare
            {
                FILE_SHARE_NONE = 0x00,
                FILE_SHARE_READ = 0x01,
                FILE_SHARE_WRITE = 0x02,
                FILE_SHARE_DELETE = 0x04
            }

            public enum FileMode
            {
                CREATE_NEW = 1,
                CREATE_ALWAYS = 2,
                OPEN_EXISTING = 3,
                OPEN_ALWAYS = 4,
                TRUNCATE_EXISTING = 5
            }

            [DllImport("Kernel32.dll", SetLastError = true)]
            private static extern bool CloseHandle(IntPtr handle);

            override protected bool ReleaseHandle()
            {
                return CloseHandle(handle);
            }
        }

        /// <summary>
        /// Importat CreateFileTransacted
        /// </summary>
        /// <returns>SafeFileHandle</returns>
        [DllImport("Kernel32.Dll", EntryPoint = "CreateFileTransacted", CharSet = CharSet.Unicode, SetLastError = true)]
        protected static extern SafeFileHandle CreateFileTransacted(
               [In] String lpFileName,
               [In] SafeTransactionHandle.FileAccess dwDesiredAccess,
               [In] SafeTransactionHandle.FileShare dwShareMode,
               [In] IntPtr lpSecurityAttributes,
               [In] SafeTransactionHandle.FileMode dwCreationDisposition,
               [In] int dwFlagsAndAttributes,
               [In] IntPtr hTemplateFile,
               [In] SafeTransactionHandle txHandle,
               [In] IntPtr miniVersion,
               [In] IntPtr extendedOpenInformation
           );

        /// <summary>
        /// Import KTM interface
        /// </summary>
        [ComImport]
        [Guid("79427A2B-F895-40e0-BE79-B57DC82ED231")]
        [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
        protected interface IKernelTransaction
        {
            void GetHandle(out SafeTransactionHandle ktmHandle);
        }

        #endregion

        #endregion


        /// <summary>
        /// Copy a file async
        /// </summary>
        /// <param name="source">Stream source</param>
        /// <param name="destination">Stream destination</param>
        /// <param name="completed">Action()</param>
        public static void CopyStreamToStream(FileStream source, FileStream destination,
                                              Action<FileStream, FileStream, Exception> completed)
        {
            byte[] buffer = new byte[0x1024];
            System.ComponentModel.AsyncOperation asyncOp = System.ComponentModel.AsyncOperationManager.CreateOperation(null);

            Action<Exception> done = e =>
            {
                if (completed != null) asyncOp.Post(delegate
                {
                    completed(source, destination, e);
                }, null);
            };

            AsyncCallback rc = null;
            rc = readResult =>
            {
                try
                {
                    int read = source.EndRead(readResult);
                    if (read > 0)
                    {
                        destination.BeginWrite(buffer, 0, read, writeResult =>
                        {
                            try
                            {
                                destination.EndWrite(writeResult);
                                source.BeginRead(
                                    buffer, 0, buffer.Length, rc, null);
                            }
                            catch (Exception exc) { done(exc); }
                        }, null);
                    }
                    else done(null);
                }
                catch (Exception exc) { done(exc); }
            };
            source.BeginRead(buffer, 0, buffer.Length, rc, null);
        }

        public static bool DirectoryIsEmpty(string path)
        {
            return PathIsDirectoryEmpty(path);
        }


        #region Transactional methods

        /// <summary>
        /// Write a file with transaction
        /// </summary>
        /// <param name="data">Data to write</param>
        /// <param name="path">Path to file</param>
        /// <returns>Statut de l'opration</returns>
        public static bool WriteStateFileTransacted(string path,XmlSerializer stateSerializer,AtomState atomState, System.Transactions.Transaction transaction)
        {
            if (atomState == null)
                return false;

            SafeTransactionHandle txHandle = null;
            SafeFileHandle fileHandle = null;
            bool response = true;
            try
            {
                IKernelTransaction kernelTx = (IKernelTransaction)TransactionInterop.GetDtcTransaction(transaction);
                kernelTx.GetHandle(out txHandle);

                fileHandle
                    = CreateFileTransacted(
                        path
                        , SafeTransactionHandle.FileAccess.GENERIC_WRITE
                        , SafeTransactionHandle.FileShare.FILE_SHARE_NONE
                        , IntPtr.Zero
                        , SafeTransactionHandle.FileMode.CREATE_ALWAYS
                        , 0
                        , IntPtr.Zero
                        , txHandle
                        , IntPtr.Zero
                        , IntPtr.Zero);

                if (fileHandle.IsInvalid)
                    throw new System.ComponentModel.Win32Exception(Marshal.GetLastWin32Error());

                using (FileStream stateFile = new FileStream(fileHandle, FileAccess.Write, 1024, false))
                {
                    stateSerializer.Serialize(stateFile, atomState);
                }
            }
            catch
            {
                transaction.Rollback();
                response = false;
            }
            finally
            {
                if (fileHandle != null && !fileHandle.IsInvalid)
                {
                    fileHandle.Close();
                    fileHandle.Dispose();
                }

                if (txHandle != null && !txHandle.IsInvalid)
                {
                    txHandle.Close();
                    txHandle.Dispose();
                }
            }
            return response;
        }


        /// <summary>
        /// Read a file with transaction
        /// </summary>
        /// <param name="path">Path to file</param>
        /// <returns>Donnes lu</returns>
        public object ReadFileTransacted(string path)
        {
            if (!File.Exists(path))
                return null;

            SafeTransactionHandle txHandle = null;
            SafeFileHandle fileHandle = null;
            object raw = null;
            try
            {
                IKernelTransaction kernelTx = (IKernelTransaction)TransactionInterop.GetDtcTransaction(System.Transactions.Transaction.Current);
                kernelTx.GetHandle(out txHandle);

                fileHandle
                    = CreateFileTransacted(
                        path
                        , SafeTransactionHandle.FileAccess.GENERIC_READ
                        , SafeTransactionHandle.FileShare.FILE_SHARE_READ
                        , IntPtr.Zero
                        , SafeTransactionHandle.FileMode.OPEN_ALWAYS
                        , 0
                        , IntPtr.Zero
                        , txHandle
                        , IntPtr.Zero
                        , IntPtr.Zero);

                if (fileHandle.IsInvalid)
                    throw new System.ComponentModel.Win32Exception(Marshal.GetLastWin32Error());

                using (FileStream stream = new FileStream(fileHandle, FileAccess.Read, 1024, false))
                {
                    BinaryFormatter reader = new BinaryFormatter();
                    raw = reader.Deserialize(stream);
                }
            }
            catch
            {
                raw = null;
            }
            finally
            {
                if (fileHandle != null && !fileHandle.IsInvalid)
                {
                    fileHandle.Close();
                    fileHandle.Dispose();
                }

                if (txHandle != null && !txHandle.IsInvalid)
                {
                    txHandle.Close();
                    txHandle.Dispose();
                }
            }
            return raw;
        }

        #endregion
    }
}












