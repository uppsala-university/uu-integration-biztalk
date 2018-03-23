using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using Shared.Components;
using System.Xml.Serialization;
using System.Xml;
using System.Security.Cryptography.X509Certificates;
using System.Collections.Concurrent;

namespace BizTalk.Adapter
{
    class Program
    {
       
        static void Main(string[] args)
        {
            string test = null;

            string root = @"C:\atom\";
            //string filename = "recent.xml";
            string filename = "state.xml";

            Console.WriteLine("START...");

            //   FileStream stm = new FileStream(root + filename, FileMode.CreateNew);


            X509Certificate2 ClientCertificate = CertificateStore.GetCertByThumbprint("b6e3448a8d92572cc9273b833f0d08248da681e7");
            string Id = "23acff5e-0be0-11e8-8f5b-0f7a53ac4427";
            string initFeed = "https://api.mit-integration.ladok.se:443/uppfoljning/feed/276367";
            //inner state cannot be the same as stae i reader ....
            StateSettings state = new StateSettings { Id = Id, WorkingFeed = initFeed,LastUpdated = DateTime.Parse("2018-01-15T08:27:42.873Z") };
        AtomReader atom = new AtomReader("https://api.mit-integration.ladok.se/uppfoljning/feed/recent", state, new SecuritySettings { ClientCertificate = CertificateStore.GetCertByThumbprint("b6e3448a8d92572cc9273b833f0d08248da681e7") },2);
            //atom.MoveToFirstFeed();

           

            Feed feed = null;


            bool discard = atom.IdFound;

            while ((feed = atom.NextFeed()) != null && feed.Entries.Count > 0)
            {
                Console.WriteLine("FEED");
                Console.WriteLine(feed.Uri);

                Entry entry = feed.Entries.PopOrNUll();

                while (entry != null)
                {
                    //atom.IdFound == true discard all until id is found
                  

                        if (discard == true)
                        {
                            Console.WriteLine(String.Format("DISCARD...{0} {1}", entry.Updated, entry.Id));
                        }
                        else
                        {
                            Console.WriteLine(String.Format("PROCESS...{0} {1}", entry.Updated, entry.Id));
                        }


                    if (Id == entry.Id)
                        discard = false;

                    entry = feed.Entries.PopOrNUll();
                } 
            }

            
            


            /*
        Stack<Queue<Entry>> stk = atom.Entries();


        while (stk.Count > 0)
        {
            Queue<Entry> queueEntry = stk.Pop();

            while (queueEntry.Count > 0)
            {
                Entry entry = queueEntry.Dequeue();

                File.AppendAllText(String.Format("{0}{1}.xml", root, entry.Id), entry.Content);

            }



        }
        */
            /*
            BizTalk.Adapter.Atom.AtomState atom = new BizTalk.Adapter.Atom.AtomState();
            atom.LastEntryId = "1234";
            atom.LastUpdated = DateTime.Now;

            XmlSerializer atomstate = new XmlSerializer(typeof(BizTalk.Adapter.Atom.AtomState));

            atomstate.Serialize(stm, atom);
            */
            Console.WriteLine("...SLUT");
            Console.ReadKey();
    }
    }

    
}
