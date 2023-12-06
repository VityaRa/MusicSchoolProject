using System.Configuration;

/// <summary>
/// Summary description for Consts
/// </summary>
public static class Consts
{
    public static string MusicConnectionString = ConfigurationManager.ConnectionStrings["musicConnectionString"].ConnectionString;
    public static string WebSiteTitle = "Гармония";
    public enum Roles
    {
        None = 0,
        Student = 1,
        Teacher = 2,
        Admin = 3,
    }

    public enum ApplicationStatus 
    { 
        Waiting = 1,
        Accepted = 2,
        Rejected = 3,
    }

    public static string AdminEmail = "admin@gmail.com";
    public static string AdminPassword = "123123";
}