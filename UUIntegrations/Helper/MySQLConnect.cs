using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;
using System.Diagnostics;

namespace Helper
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
            Initialize();
        }
        
        private void Initialize()
        {
            server = "ladoktestdb-uu.its.uu.se";
            database = "uu";
            uid = "l2adapter";
            password = "Gx8!SU4b";
            string connectionString;
            connectionString = "SERVER=" + server + ";" + "DATABASE=" +
            database + ";" + "UID=" + uid + ";" + "PASSWORD=" + password + ";";

            connection = new MySqlConnection(connectionString);
        }
        
        private bool OpenConnection()
        {
            try
            {
                connection.Open();
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
                connection.Close();
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
        
        public string GetCourseDescriptions(string utbildningsinstansUID)
        {
            string query = "SELECT * FROM uu.kurs where kod='" + utbildningsinstansUID + "'";
            string value = "";            
            
            if (this.OpenConnection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, connection);
                MySqlDataReader dataReader = cmd.ExecuteReader();
                
                while (dataReader.Read())
                {
                    value = dataReader["benamns"] + "~" + dataReader["benamne"];
                }
                
                dataReader.Close();
                
                this.CloseConnection();
                
                return value;
            }
            else
            {
                return value;
            }
        }


        public string GetSemesters(string startperiodID, string utbildningstillfalleskod)
        {
            string query = "SELECT termin, termordn FROM uu.ktfort2 WHERE kod = " + utbildningstillfalleskod + " AND startter = " + startperiodID + " ORDER BY termordn";
            string value = startperiodID;

            if (this.OpenConnection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, connection);
                MySqlDataReader dataReader = cmd.ExecuteReader();

                while (dataReader.Read())
                {
                    value += "~" + dataReader["termin"];
                }

                dataReader.Close();

                this.CloseConnection();

                return value;
            }
            else
            {
                return value;
            }
        }

    }
}
