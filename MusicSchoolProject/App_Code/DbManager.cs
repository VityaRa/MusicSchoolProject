using System.Configuration;
using System.Data.SqlClient;

public class DbManager
{
    private static readonly object lockObject = new object();
    private static SqlConnection connection;

    private DbManager() {
        
    }

    public static SqlConnection GetConnection()
    {
        lock (lockObject)
        {
            if (connection == null)
            {
                // Замените "MusicConnectionString" на имя вашей строки подключения
                SqlConnection connection = new SqlConnection(Consts.MusicConnectionString);
                return connection;
            }

            return connection;
        }
    }
}
