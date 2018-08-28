using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace INT0017InitUsmrDB
{
    class InitUsmrDB
    {
        static SqlConnection myConnection;
        static void Main(string[] args)
        {
            string filename = "E:\"+UUSKLISTTEST";
            string username = "usmr";
            string pwd = "password";
            string database = "sd-usmr-test-db";
            string server = "localhost";
            //string server = "mssql://localhost:1433//sd-usmr-test-db";

            if (args != null && args.Length != 5)
            {
                Console.WriteLine("USAGE: <inputfile> <dbuser> <pwd> <dbname> <dbserver>");
                Console.WriteLine("Press any key to exit.");
                System.Console.ReadKey();
            }
            else {

                filename = args[0];
                username = args[1];
                pwd = args[2];
                database = args[3];
                server = args[4];


                myConnection = new SqlConnection("user id=" + username + ";" +
                                       "password=" + pwd + ";server=" + server + ";" +
                                       "Trusted_Connection=yes;" +
                                       "database=" + database + "; " +
                                       "connection timeout=30");


            InitDB(filename, myConnection);
        }
   
        }

        static string InitDB(string filename, SqlConnection sqlConnection)
        {

           // string[] lines = System.IO.File.ReadAllLines(@"E:\" + filename);
            string[] lines = System.IO.File.ReadAllLines(@filename);

            // Display the file contents by using a foreach loop.
            System.Console.WriteLine("loading " + filename + ":");
            int lineNr = 0;
            foreach (string line in lines)
            {
                if (lineNr > 0)
                {
                    string[] columns = line.Split(';');
                    loadUsmrData(sqlConnection, columns);
                }

                lineNr++;
            }
            Console.WriteLine("\t" + lineNr + " records loaded");



            // Keep the console window open in debug mode.
            Console.WriteLine("Press any key to exit.");
            System.Console.ReadKey();
            return "";
        }


        static string loadUsmrData(SqlConnection sqlConnection, string[] columns)
        {
            string PNR = Trimdata(columns[0]);
            string GPNR = Trimdata(columns[1]);
            string EFTERNAMN = Trimdata(columns[2]);
            string FORNAMN = Trimdata(columns[3]);
            string INLDATUM_PERS = Trimdata(columns[4]);
            string COADRESS = Trimdata(columns[5]);
            string GATUADRESS = Trimdata(columns[6]);
            string POSTNR = Trimdata(columns[7]);
            string ORT = Trimdata(columns[8]);
            string LAND = Trimdata(columns[9]);
            string INLDATUM_ADRESS = Trimdata(columns[10]);
            string TELNR = Trimdata(columns[11]);
            string INLDATUM_TELNR = Trimdata(columns[12]);
            string EPOSTADRESS = Trimdata(columns[13]);
            string UPPEH = Trimdata(columns[14]);
            string KURS = Trimdata(columns[15]);
            string INST = Trimdata(columns[16]);
            string POANG = Trimdata(columns[17]);
            string KT = Trimdata(columns[18]);
            string UF = Trimdata(columns[19]);
            string KORT = Trimdata(columns[20]);
            string FIN = Trimdata(columns[21]);
            string PROGR = Trimdata(columns[22]);
            string AKT = Trimdata(columns[23]);
            string TERMIN = Trimdata(columns[24]);
            string PTAKT = Trimdata(columns[25]);
            string KAR = Trimdata(columns[26]);
            string TYP = Trimdata(columns[27]);
            string PLG = Trimdata(columns[28]);

            try
            {

                SqlCommand cmd = new SqlCommand("INSERT INTO dbo.[\"UUSKLIST\"] (PNR, GPNR,EFTERNAMN, FORNAMN, INLDATUM_PERS,COADRESS,GATUADRESS,POSTNR,ORT,LAND,INLDATUM_ADRESS,TELNR,INLDATUM_TELNR,EPOSTADRESS,UPPEH,KURS,INST,POANG,KT,UF,KORT,FIN,PROGR,AKT,TERMIN,PTAKT,KAR,TYP,PLG) VALUES (@PNR, @GPNR,@EFTERNAMN, @FORNAMN, @INLDATUM_PERS,@COADRESS,@GATUADRESS,@POSTNR,@ORT,@LAND,@INLDATUM_ADRESS,@TELNR,@INLDATUM_TELNR,@EPOSTADRESS,@UPPEH,@KURS,@INST,@POANG,@KT,@UF,@KORT,@FIN,@PROGR,@AKT,@TERMIN,@PTAKT,@KAR,@TYP,@PLG) ", sqlConnection);
                cmd.Parameters.AddWithValue("@PNR", PNR);
                cmd.Parameters.AddWithValue("@GPNR", GPNR);
                cmd.Parameters.AddWithValue("@EFTERNAMN", EFTERNAMN);
                cmd.Parameters.AddWithValue("@FORNAMN", FORNAMN);
                cmd.Parameters.AddWithValue("@INLDATUM_PERS", INLDATUM_PERS);
                cmd.Parameters.AddWithValue("@COADRESS", COADRESS);
                cmd.Parameters.AddWithValue("@GATUADRESS", GATUADRESS);
                cmd.Parameters.AddWithValue("@POSTNR", POSTNR);
                cmd.Parameters.AddWithValue("@ORT", ORT);
                cmd.Parameters.AddWithValue("@LAND", LAND);
                cmd.Parameters.AddWithValue("@INLDATUM_ADRESS", INLDATUM_ADRESS);
                cmd.Parameters.AddWithValue("@TELNR", TELNR);
                cmd.Parameters.AddWithValue("@INLDATUM_TELNR", INLDATUM_TELNR);
                cmd.Parameters.AddWithValue("@EPOSTADRESS", EPOSTADRESS);
                cmd.Parameters.AddWithValue("@UPPEH", UPPEH);
                cmd.Parameters.AddWithValue("@KURS", KURS);
                cmd.Parameters.AddWithValue("@INST", INST);
                cmd.Parameters.AddWithValue("@POANG", POANG);
                cmd.Parameters.AddWithValue("@KT", KT);
                cmd.Parameters.AddWithValue("@UF", UF);
                cmd.Parameters.AddWithValue("@KORT", KORT);
                cmd.Parameters.AddWithValue("@FIN", FIN);
                cmd.Parameters.AddWithValue("@PROGR", PROGR);
                cmd.Parameters.AddWithValue("@AKT", AKT);
                cmd.Parameters.AddWithValue("@TERMIN", TERMIN);
                cmd.Parameters.AddWithValue("@PTAKT", PTAKT);
                cmd.Parameters.AddWithValue("@KAR", KAR);
                cmd.Parameters.AddWithValue("@TYP", TYP);
                cmd.Parameters.AddWithValue("@PLG", PLG);

                sqlConnection.Open();
                cmd.ExecuteNonQuery();
            }

            catch
            {

            }

            finally
            {
                sqlConnection.Close();
            }

            return "";
        }

        static string Trimdata(string value)
        {
            if (value != null)
            {
                return value.Trim();
            } else
            {
                return "";
            }
        }
    }

  


}
