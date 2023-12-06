using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SiteMaster : MasterPage
{
    private void onAuthorizedUser()
    {
        RegisterLinkButton.Visible = false;
        LoginLinkButton.Visible = false;
    }

    private void onAnonymousUser()
    {
        RegisterLinkButton.Visible = true;
        LoginLinkButton.Visible = true;
    }
    private void GetNonAcceptableLinks(int userRoleId)
    {
        // TODO: get links based of user session role

    }
    private void HideLinks()
    {
        // get user role, invoke GetNonAcceptableLinks and map for elements and make Visible = false for links
        var userRole = Convert.ToInt32(Session[SessionConsts.UserRoleId]);
        if (userRole == 0)
        {

        }
    }

    private void RemoveLinkButtonValidation()
    {
        MainLinkButton.CausesValidation = false;
        ScheduleLinkButton.CausesValidation = false;
        GradeLinkButton.CausesValidation = false;
        GroupLinkButton.CausesValidation = false;
        ApplicationsLinkButton.CausesValidation = false;
        RegisterLinkButton.CausesValidation = false;
        LoginLinkButton.CausesValidation = false;
    }

    private void HandleAuthorization()
    {
        var userRoleId = Convert.ToInt32(Session[SessionConsts.UserRoleId]);
        if (userRoleId == 0)
        {
            onAnonymousUser();
        }
        else 
        {
            onAuthorizedUser();
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        RemoveLinkButtonValidation();
        HideLinks();
        HandleAuthorization();
    }

    protected void LinkButtonClick(object sender, EventArgs e)
    {
        RegisterLinkButton.CausesValidation = false;
        LinkButton button = (LinkButton)sender;
        string buttonId = button.ID;
        if (buttonId == MainLinkButton.ID)
        {
            Response.Redirect(Pages.DefaultPage);
        }
        if (buttonId == ScheduleLinkButton.ID)
        {
            Response.Redirect(Pages.SchedulePage);
        }
        if (buttonId == GradeLinkButton.ID)
        {
            Response.Redirect(Pages.GradesPage);
        }
        if (buttonId == GroupLinkButton.ID)
        {
            Response.Redirect(Pages.GroupsPage);
        }
        if (buttonId == ApplicationsLinkButton.ID)
        {
            Response.Redirect(Pages.ApplicationsPage);
        }
        if (buttonId == RegisterLinkButton.ID)
        {
            Response.Redirect(Pages.RegisterPage);
        }
        if (buttonId == LoginLinkButton.ID)
        {
            Response.Redirect(Pages.LoginPage);
        }
    }
}