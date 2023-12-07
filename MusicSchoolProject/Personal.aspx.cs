using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PersonalPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            return;
        }

        var loggedUserId = Convert.ToInt32(Session[SessionConsts.UserId]);
        var userId = Convert.ToInt32(Request.QueryString[SessionConsts.UserId]);

        if (userId == 0)
        {
            Response.Redirect(Pages.DefaultPage);
            return;
        }


        if (userId != loggedUserId)
        {
            Response.Redirect(Pages.DefaultPage);
            return;
        }
        GetStudentData.SelectParameters[SessionConsts.UserId].DefaultValue = userId.ToString();
        GetStudentData.UpdateParameters[SessionConsts.UserId].DefaultValue = userId.ToString();
        GetStudentData.DataBind();
    }

    protected void StudentDetailsFormView_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        string name = e.NewValues["name"] as string;
        string lastname = e.NewValues["lastname"] as string;
        string fathername = e.NewValues["fathername"] as string;
        string address = e.NewValues["address"] as string;
        string password = e.NewValues["password"] as string;
        string email = e.NewValues["email"] as string;

        GetStudentData.UpdateParameters["name"].DefaultValue = name;
        GetStudentData.UpdateParameters["lastname"].DefaultValue = lastname;
        GetStudentData.UpdateParameters["fathername"].DefaultValue = fathername;
        GetStudentData.UpdateParameters["address"].DefaultValue = address;
        GetStudentData.UpdateParameters["password"].DefaultValue = password;
        GetStudentData.UpdateParameters["email"].DefaultValue = email;
        var loggedUserId = Convert.ToInt32(Session[SessionConsts.UserId]);

        GetStudentData.UpdateParameters[SessionConsts.UserId].DefaultValue = loggedUserId.ToString();
    }

    protected void StudentDetailsFormView_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            StudentDetailsFormView.ChangeMode(FormViewMode.Edit);
        }
    }

    protected void StudentDetailsFormView_ModeChanging(object sender, FormViewModeEventArgs e)
    {
        StudentDetailsFormView.ChangeMode(e.NewMode);
    }
}