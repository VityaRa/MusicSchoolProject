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
    private Dictionary<int, List<string>> rolePageAccess = new Dictionary<int, List<string>>
    {
        { 0, new List<string> { Pages.DefaultPage, Pages.SchedulePage, Pages.LoginPage, Pages.RegisterPage } },
        { 1, new List<string> { Pages.DefaultPage, Pages.SchedulePage, Pages.GradesPage, Pages.PersonalPage } },
        { 2, new List<string> { Pages.DefaultPage, Pages.SchedulePage, Pages.GradesPage, Pages.GroupsPage, Pages.PersonalPage } },
        { 3, new List<string> {  } },
    };

    private void onAuthorizedUser()
    {
        RegisterLinkButton.Visible = false;
        LoginLinkButton.Visible = false;
        WelcomeMessage.Visible = true;
        WelcomeMessage.Text = "Добро пожаловать, " + Session[SessionConsts.UserName] + "!";
        LogoutLinkButton.Visible = true;
        PersonalDataLinkButton.Visible = true;
    }
    private void onAnonymousUser()
    {
        RegisterLinkButton.Visible = true;
        LoginLinkButton.Visible = true;
        WelcomeMessage.Visible = false;
        LogoutLinkButton.Visible = false;
        PersonalDataLinkButton.Visible = false;
    }
    private void onLogout()
    {
        Session.Clear();
    }


    private List<LinkButton> GetNonAcceptableLinks(int userRoleId)
    {
        if (userRoleId == 0)
        {
            return new List<LinkButton>
            {
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
        return new List<LinkButton> {
            PersonalDataLinkButton
        };
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

    private void CheckPageAccess()
    {
        int userRoleId = GetRole();
        string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath); // Получаем имя текущей страницы

        // Проверяем, есть ли у пользователя доступ к текущей странице
        if (!rolePageAccess.ContainsKey(userRoleId) || !rolePageAccess[userRoleId].Contains(currentPage) && userRoleId != 3)
        {
            Response.Redirect(Pages.DefaultPage);
            Response.End();
        }
    }

    private void DEBUG_ROLE(int role)
    {
        Session[SessionConsts.UserRoleId] = role;
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        //DEBUG_ROLE(2);
        CheckPageAccess();
        RemoveLinkButtonValidation();
        HandleAuthorization();
        HideLinks();
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
        if (buttonId == PersonalDataLinkButton.ID)
        {
            var redirectUrl = Utils.MakePersonalPageRedirect(Convert.ToInt32(Session[SessionConsts.UserId]));
            Response.Redirect(redirectUrl);
        }
    }
}