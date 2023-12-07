using System;
using System.Data.SqlClient;
using static Consts;

public class RequestHelper
{
    public static void InsertApplication(ApplicationModel applicationData)
    {
        using (SqlConnection connection = DbManager.GetConnection())
        {
            connection.Open();

            string insertQuery = "INSERT INTO application (name, lastName, fatherName, birthdate, description, disciplineID, address, email, created_at, password, status_id) " +
                                "VALUES (@name, @lastName, @fatherName, @birthdate, @description, @disciplineID, @address, @email, @created_at, @password, @status_id)";

            using (SqlCommand command = new SqlCommand(insertQuery, connection))
            {
                // Добавление параметров
                command.Parameters.AddWithValue("@name", applicationData.name);
                command.Parameters.AddWithValue("@lastName", applicationData.lastname);
                command.Parameters.AddWithValue("@fatherName", applicationData.fathername);
                command.Parameters.AddWithValue("@birthdate", applicationData.birthdate);
                command.Parameters.AddWithValue("@description", applicationData.description);
                command.Parameters.AddWithValue("@disciplineID", applicationData.disciplineID);
                command.Parameters.AddWithValue("@address", applicationData.address);
                command.Parameters.AddWithValue("@email", applicationData.email);
                command.Parameters.AddWithValue("@created_at", applicationData.created_at);
                command.Parameters.AddWithValue("@password", applicationData.password);
                command.Parameters.AddWithValue("@status_id", applicationData.status_id);

                // Выполнение запроса
                command.ExecuteNonQuery();
            }
        }
    }

    public static int CreateCreds(Credentials creds)
    {
        using (SqlConnection connection = DbManager.GetConnection())
        {
            connection.Open();

            string insertQuery = "INSERT INTO credentials (roleId, email, password, userId) " +
                                "VALUES (@roleId, @email, @password, @userId);" +
                                "SELECT SCOPE_IDENTITY()";

            using (SqlCommand command = new SqlCommand(insertQuery, connection))
            {
                // Добавление параметров
                command.Parameters.AddWithValue("@roleId", creds.roleId);
                command.Parameters.AddWithValue("@email", creds.email);
                command.Parameters.AddWithValue("@password", creds.password);
                command.Parameters.AddWithValue("@userId", creds.userId);

                // Выполнение запроса
                return Convert.ToInt32(command.ExecuteScalar());
            }
        }
    }
    public static int CreateStudent(Student student)
    {
        var studentId = -1;
        using (SqlConnection connection = DbManager.GetConnection())
        {
            connection.Open();

            string insertQuery = "INSERT INTO student (name, lastName, fatherName, birthdate, disciplineID, admission_year, address) " +
                                "VALUES (@name, @lastName, @fatherName, @birthdate, @disciplineID, @admission_year, @address);" +
                                "SELECT SCOPE_IDENTITY()";

            using (SqlCommand command = new SqlCommand(insertQuery, connection))
            {
                command.Parameters.AddWithValue("@name", student.name);
                command.Parameters.AddWithValue("@lastName", student.lastname);
                command.Parameters.AddWithValue("@fatherName", student.fathername);
                command.Parameters.AddWithValue("@birthdate", student.birthdate);
                command.Parameters.AddWithValue("@disciplineID", student.disciplineID);
                command.Parameters.AddWithValue("@admission_year", student.admission_year);
                command.Parameters.AddWithValue("@address", student.address);

                studentId = Convert.ToInt32(command.ExecuteScalar());
            }
        }

        return studentId;
    }

    public static ApplicationModel GetApplicationByID(int applicationID)
    {
        ApplicationModel application = null;

        using (SqlConnection connection = DbManager.GetConnection())
        {
            connection.Open();

            string query = "SELECT * FROM application WHERE applicationID = @applicationID";
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@applicationID", applicationID);

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        application = new ApplicationModel
                        {
                            applicationID = Convert.ToInt32(reader["applicationID"]),
                            name = reader["name"].ToString(),
                            lastname = reader["lastname"].ToString(),
                            fathername = reader["fathername"].ToString(),
                            description = reader["description"].ToString(),
                            disciplineID = Convert.ToInt32(reader["disciplineID"]),
                            created_at = Convert.ToDateTime(reader["created_at"]),
                            birthdate = Convert.ToDateTime(reader["birthdate"]),
                            email = reader["email"].ToString(),
                            address = reader["address"].ToString(),
                            password = reader["password"].ToString(),
                            status_id = Convert.ToInt32(reader["status_id"])
                        };
                    }
                }
            }
        }

        return application;
    }
    public static void MarkApplication(int applicationId, ApplicationStatus newStatus)
    {
        using (SqlConnection connection = DbManager.GetConnection())
        {
            connection.Open();

            string query = "UPDATE application SET status_id = @status_id WHERE applicationID = @applicationID";

            using (SqlCommand command = new SqlCommand(query, connection))
            {
                // Добавляем параметр для безопасности
                command.Parameters.AddWithValue("@applicationID", applicationId);
                command.Parameters.AddWithValue("@status_id", (int)newStatus);

                // Выполняем запрос
                command.ExecuteNonQuery();
            }
        }
    }

    public static void MarkApplicationAccepted(int applicationId)
    {
        MarkApplication(applicationId, ApplicationStatus.Accepted);
    }

    public static void MarkApplicationRejected(int applicationId)
    {
        MarkApplication(applicationId, ApplicationStatus.Rejected);
    }

    public class GetUserByCredentialsResponse
    {
        public int roleId { get; set; }
        public string name { get; set; }
        public int userId { get; set; }

    }

    public static Credentials GetCredentials(string email, string password)
    {
        Credentials credential = null;

        using (SqlConnection connection = DbManager.GetConnection())
        {
            connection.Open();

            string query = "SELECT * FROM credentials WHERE email = @email AND password = @password";
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@email", email);
                command.Parameters.AddWithValue("@password", password);

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        credential = new Credentials
                        {
                            credentialId = Convert.ToInt32(reader["credentialId"]),
                            roleId = Convert.ToInt32(reader["roleId"]),
                            email = reader["email"].ToString(),
                            password = reader["password"].ToString(),
                            userId = Convert.ToInt32(reader["userId"]),
                        };
                    }
                }
            }
        }

        return credential;
    }

    public class UserTableMetadata
    {
        public string name { get; set; }
        public string idField { get; set; }
    }
    public enum UserTableType
    {
        Student,
        Teacher,
    }
    public static UserTableMetadata GetTableMetadata(UserTableType tableType)
    {
        if (tableType == UserTableType.Teacher)
        {
            return new UserTableMetadata
            {
                name = "teacher",
                idField = "teacherID",
            };
        }

        if (tableType == UserTableType.Student)
        {
            return new UserTableMetadata
            {
                name = "student",
                idField = "studentID",
            };
        }

        throw new Exception("Incorrect tableType found");
    }


    private static Student GetFullNameById(int userId, UserTableType tableName)
    {
        Student student = null;

        using (SqlConnection connection = DbManager.GetConnection())
        {
            connection.Open();
            var tableMeta = GetTableMetadata(tableName);
            string query = "SELECT * FROM " + tableMeta.name + " WHERE " + tableMeta.idField + " = @userId";
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@userId", userId);
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        student = new Student
                        {
                            name = reader["name"].ToString(),
                            lastname = reader["lastname"].ToString(),
                            fathername = reader["fathername"].ToString(),
                            studentID = Convert.ToInt32(reader[tableMeta.idField]),
                        };
                    }
                }
            }
        }

        return student;
    }

    public static GetUserByCredentialsResponse GetUserByCredentials(Credentials creds)
    {
        try
        {
            Credentials credentials = GetCredentials(creds.email, creds.password);
            if (credentials == null)
            {
                return null;
            }
            if (credentials.roleId == (int)Roles.Admin)
            {
                return new GetUserByCredentialsResponse
                {
                    roleId = (int)Roles.Admin,
                    name = "Admin",
                    userId = -1,
                };
            }

            UserTableType tableType = UserTableType.Student;
            if (credentials.roleId == (int)Roles.Teacher)
            {
                tableType = UserTableType.Teacher;
            }

            Student student = GetFullNameById(credentials.userId, tableType);
            return new GetUserByCredentialsResponse
            {
                roleId = credentials.roleId,
                name = student.name,
                userId = student.studentID
            };
        }
        catch
        {
            return null;
        }

    }
}
