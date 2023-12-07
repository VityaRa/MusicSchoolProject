using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Utils
/// </summary>
public class Utils
{
    public static string GetFullName(Student student)
    {
        return student.name + " " + student.lastname + " " + student.fathername;
    }

    public static string MakePersonalPageRedirect(int userId)
    {
        return Pages.PersonalPage + "?" + SessionConsts.UserId + "=" + userId;
    }
}