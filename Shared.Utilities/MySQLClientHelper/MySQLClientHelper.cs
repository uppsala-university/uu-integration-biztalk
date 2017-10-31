using MySql.Data.MySqlClient;
using System;
using System.Diagnostics;

namespace Shared.Utilities.MySQLClientHelper
{
    public class MySQLConnect
    {
        private MySqlConnection connection;
        private string server;
        private string database;
        private string uid;
        private string password;

        public MySQLConnect()
        {
            this.Initialize();
        }

        private void Initialize()
        {
            this.server = Shared.Utilities.SSOClientHelper.SSOClientHelper.Read("Shared.Utilities.MySQLClientHelper", "server");
            this.database = Shared.Utilities.SSOClientHelper.SSOClientHelper.Read("Shared.Utilities.MySQLClientHelper", "database");
            this.uid = Shared.Utilities.SSOClientHelper.SSOClientHelper.Read("Shared.Utilities.MySQLClientHelper", "uid");
            this.password = Shared.Utilities.SSOClientHelper.SSOClientHelper.Read("Shared.Utilities.MySQLClientHelper", "password");
            this.connection = new MySqlConnection(string.Format("SERVER=\"{0}\";DATABASE=\"{1}\";UID=\"{2}\";PASSWORD=\"{3}\";", new object[4]
            {
        (object) this.server,
        (object) this.database,
        (object) this.uid,
        (object) this.password
            }));
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
            string cmdText = "SELECT tnamn + ',' + enamn as fullname FROM uu.namn where pnr='" + pnr + "'";
            string str = "";
            if (this.OpenConnection())
            {
                MySqlDataReader mySqlDataReader = new MySqlCommand(cmdText, this.connection).ExecuteReader();
                if (mySqlDataReader.Read())
                    str = mySqlDataReader["fullname"].ToString();
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
