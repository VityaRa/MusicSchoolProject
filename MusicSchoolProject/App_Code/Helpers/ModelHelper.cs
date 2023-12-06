using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ModelHelper
/// </summary>
public class ModelHelper
{
    public static Student GetUserDataFromApplication(ApplicationModel application)
    {
        return new Student
        {
            name = application.name,
            lastname = application.lastname,
            fathername = application.fathername,
            disciplineID = application.disciplineID,
            birthdate = application.birthdate,
            admission_year = application.created_at.Year,
            address = application.address,
        };
    }
}