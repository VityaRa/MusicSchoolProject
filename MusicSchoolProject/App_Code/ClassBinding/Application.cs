using System;

public class ApplicationModel
{
    public int applicationID { get; set; }
    public string name { get; set; }
    public string lastname { get; set; }
    public string fathername { get; set; }
    public string description { get; set; }
    public int disciplineID { get; set; }
    public DateTime created_at { get; set; }
    public DateTime birthdate { get; set; }
    public string email { get; set; }
    public string address { get; set; }
    public string password { get; set; }
    public int status_id { get; set; }
}