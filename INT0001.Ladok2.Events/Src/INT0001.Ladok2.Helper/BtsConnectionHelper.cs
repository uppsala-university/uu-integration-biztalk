using Microsoft.Win32;

namespace INT0001.Ladok2
{
  public class BtsConnectionHelper
  {
    private static string mgmtdb_connection = string.Empty;
    private const string REG_KEY_BTS_ADMINISTRATION = "SOFTWARE\\Microsoft\\BizTalk Server\\3.0\\Administration";
    private const string MgmtDBName = "MgmtDBName";
    private const string MgmtDBServer = "MgmtDBServer";

    public static string MgmtDBConnectionString
    {
      get
      {
        if (BtsConnectionHelper.mgmtdb_connection == string.Empty)
        {
          RegistryKey registryKey = Registry.LocalMachine.OpenSubKey("SOFTWARE\\Microsoft\\BizTalk Server\\3.0\\Administration", false);
          BtsConnectionHelper.mgmtdb_connection = string.Format("Data Source={0};Initial Catalog={1};Integrated Security=SSPI;", registryKey.GetValue("MgmtDBServer"), registryKey.GetValue("MgmtDBName"));
        }
        return BtsConnectionHelper.mgmtdb_connection;
      }
    }
  }
}
