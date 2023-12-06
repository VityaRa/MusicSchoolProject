using System;
using System.Web.UI;
using static RequestHelper;

public partial class Account_Login : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void LogIn(object sender, EventArgs e)
    {
        if (IsValid)
        {
            var creds = new Credentials()
            {
                email = UserName.Text,
                password = Password.Text,
            };

            GetUserByCredentialsResponse student = GetUserByCredentials(creds);
            if (student != null)
            {
                Session[SessionConsts.UserRoleId] = student.role;
                Session[SessionConsts.UserName] = student.name;
                Response.Redirect(Pages.SchedulePage);
            }
            else
            {
                FailureText.Text = "Неверный логин или пароль.";
                ErrorMessage.Visible = true;
            }
        }
    }
}