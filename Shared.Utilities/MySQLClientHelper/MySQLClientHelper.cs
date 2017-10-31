using MySql.Data.MySqlClient;
using System;
using System.Diagnostics;
using System.Text;

namespace Shared.Utilities.MySQLClientHelper
{
    public class MySQLConnect
    {
        private MySqlConnection connection;

        public MySQLConnect()
        {
            this.Initialize();
        }

        private void Initialize()
        { 
             string server = Shared.Utilities.SSOClientHelper.SSOClientHelper.Read("Shared.Utilities.MySQLClientHelper", "server");
             string database = Shared.Utilities.SSOClientHelper.SSOClientHelper.Read("Shared.Utilities.MySQLClientHelper", "database");
             string uid = Shared.Utilities.SSOClientHelper.SSOClientHelper.Read("Shared.Utilities.MySQLClientHelper", "uid");
             string password = Shared.Utilities.SSOClientHelper.SSOClientHelper.Read("Shared.Utilities.MySQLClientHelper", "password");

            connection = new MySqlConnection(String.Format("SERVER=\"{0}\";DATABASE=\"{1}\";UID=\"{2}\";PASSWORD=\"{3}\";", server, database, uid, password));

        }

        private bool OpenConnection()
        {
            try
            {
                this.connection.Open();
                return true;
            }
            catch (Exception ex)
            {
                using (EventLog eventLog = new EventLog("Application"))
                {
                    eventLog.Source = "Application";
                    eventLog.WriteEntry(ex.Message, EventLogEntryType.Error);
                }
                return false;
            }
        }

        private bool CloseConnection()
        {
            try
            {
                this.connection.Close();
                return true;
            }
            catch (Exception ex)
            {
                using (EventLog eventLog = new EventLog("Application"))
                {
                    eventLog.Source = "Application";
                    eventLog.WriteEntry(ex.Message, EventLogEntryType.Error);
                }
                return false;
            }
        }

        public string GetFullname(string pnr)
        {
            string cmdText = "SELECT tnamn, enamn FROM uu.namn where pnr='" + pnr + "'";
            string str = "";
            if (this.OpenConnection())
            {
                MySqlDataReader mySqlDataReader = new MySqlCommand(cmdText, this.connection).ExecuteReader();
                if (mySqlDataReader.Read())
                    str = String.Format("{0},{1}",mySqlDataReader[0], mySqlDataReader[1]);
                mySqlDataReader.Close();
                this.CloseConnection();
            }
            return str;
        }

        public string GetCourseDescriptions(string utbildningsinstansUID)
        {
            string cmdText = "SELECT * FROM uu.kurs where kod='" + utbildningsinstansUID + "'";
            string str = "";
            if (!this.OpenConnection())
                return str;
            MySqlDataReader mySqlDataReader = new MySqlCommand(cmdText, this.connection).ExecuteReader();
            while (mySqlDataReader.Read())
                str = mySqlDataReader["benamns"].ToString() + "~" + mySqlDataReader["benamne"];
            mySqlDataReader.Close();
            this.CloseConnection();
            return str;
        }

        public string GetSemesters(string startperiodID, string utbildningstillfalleskod)
        {
            string cmdText = "SELECT termin, termordn FROM uu.ktfort2 WHERE kod='" + utbildningstillfalleskod + "' AND startter='" + startperiodID + "' ORDER BY termordn";
            string str = startperiodID;
            if (!this.OpenConnection())
                return str;
            MySqlDataReader mySqlDataReader = new MySqlCommand(cmdText, this.connection).ExecuteReader();
            while (mySqlDataReader.Read())
                str = str + "~" + mySqlDataReader["termin"];
            mySqlDataReader.Close();
            this.CloseConnection();
            return str;
        }
    }
}
