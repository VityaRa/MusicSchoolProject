using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

public partial class GroupList : System.Web.UI.Page
{
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
    protected void Page_Load(object sender, EventArgs e)
    {
        var role = GetRole();
        if (role == 3)
        {
            GetGroups.SelectParameters["teacherId"].DefaultValue = "-1";
        }
        if (role == 2)
        {
            GetGroups.SelectParameters["teacherId"].DefaultValue = Session[SessionConsts.UserId].ToString();
        }
    }

    private void ShowGroupSelected(String groupName)
    {
        GroupSelectedLabel.Text = "Состав группы " + groupName;
        GroupSelectedLabel.Visible = true;
    }
    protected void GroupsGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        string selectedGroupID = GroupsGridView.SelectedDataKey["groupID"].ToString();
        GetStudentsListByGroupId.SelectParameters["groupID"].DefaultValue = selectedGroupID;
        StudentsList.Visible = true;
        StudentsList.DataBind();

        int selectedIndex = GroupsGridView.SelectedIndex;
        GridViewRow selectedRow = GroupsGridView.Rows[selectedIndex];
        string groupName = selectedRow.Cells[1].Text; // Используйте правильный индекс ячейки
        ShowGroupSelected(groupName);
    }

    protected void HandleClickOnStudent(object sender, EventArgs e)
    {

    }

}