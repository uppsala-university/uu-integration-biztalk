using Microsoft.BizTalk.ExplorerOM;
using System.Collections;

namespace INT0001.Ladok2
{
  public class Helper
  {
    public static BtsCatalogExplorer bceExplorer = (BtsCatalogExplorer) null;
    public static ReceivePort port = (ReceivePort) null;
    public static bool state = true;

    public static void UpdateState(string portname, bool enabled)
    {
      if (Helper.port == null)
      {
        Helper.bceExplorer = new BtsCatalogExplorer();
        Helper.bceExplorer.ConnectionString = BtsConnectionHelper.MgmtDBConnectionString;
        Helper.port = Helper.bceExplorer.ReceivePorts[portname];
      }
      foreach (ReceiveLocation receiveLocation in (ReadOnlyCollectionBase) Helper.port.ReceiveLocations)
        receiveLocation.Enable = enabled;
      Helper.bceExplorer.SaveChanges();
      Helper.state = enabled;
    }

    public static bool State
    {
      get
      {
        return Helper.state;
      }
    }
  }
}
