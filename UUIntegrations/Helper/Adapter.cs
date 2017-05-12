using Microsoft.BizTalk.ExplorerOM;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Helper
{
    public enum Active
    {
        Start,
        Stop
    }

    public class Adapter
    {
        public static void RecieveLocationStateChange(string ReceivePort, string ReceiveLocation, Active ActiveFlag)
        {
            BtsCatalogExplorer root = new BtsCatalogExplorer();
            try
            {
                root.ConnectionString = "Server=.;Initial Catalog=BizTalkMgmtDb;Integrated Security=SSPI;";

                //Enumerate the receive locations in each of the receive ports.
                foreach (ReceivePort receivePort in root.ReceivePorts)
                {

                    if (receivePort.Name == ReceivePort)
                    {
                        foreach (ReceiveLocation location in receivePort.ReceiveLocations)
                            if (location.Name == ReceiveLocation)
                            {
                                switch (ActiveFlag)
                                {
                                    case Active.Start:
                                        location.Enable = true;
                                        break;
                                    case Active.Stop:
                                        location.Enable = false;
                                        break;
                                    default:
                                        location.Enable = true;
                                        break;
                                }

                            }
                    }
                }
                root.SaveChanges();
            }
            catch (Exception e)
            {
                root.DiscardChanges();
                throw e;
            }
        }
    }
}
