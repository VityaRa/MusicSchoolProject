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
        WelcomeMessage.Visible = true;
        WelcomeMessage.Text = "Добро пожаловать, " + Session[SessionConsts.UserName] + "!";
        LogoutLinkButton.Visible = true;
    }

    private void onLogout()
    {
        Session.Clear();
    }

    private void onAnonymousUser()
    {
        RegisterLinkButton.Visible = true;
        LoginLinkButton.Visible = true;
        WelcomeMessage.Visible = false;
        LogoutLinkButton.Visible = false;
    }
    private List<LinkButton> GetNonAcceptableLinks(int userRoleId)
    {
        if (userRoleId == 0)
        {
            return new List<LinkButton>
            {
                GradeLinkButton,
                ApplicationsLinkButton,
                GroupLinkButton,
            };
        }
        if (userRoleId == 1)
        {
            return new List<LinkButton>
            {
                ApplicationsLinkButton,
                GroupLinkButton,
            };
        }
        if (userRoleId == 2)
        {
            return new List<LinkButton>
            {
                ApplicationsLinkButton,
            };
        }
        return new List<LinkButton> {};
    }

    private int GetRole()
    {
        try
        {
            return Convert.ToInt32(Session[SessionConsts.UserRoleId]);
        }
        catch
        {
            return 0;
        }
    }
    private void HideLinks()
    {
        var roleId = GetRole();
        var hideLinks = GetNonAcceptableLinks(roleId);
        hideLinks.ForEach(link => link.Visible = false);
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
        var userRoleId = GetRole();
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
        if (buttonId == LogoutLinkButton.ID)
        {
            onLogout();
            Response.Redirect(Pages.DefaultPage);
        }
    }
}