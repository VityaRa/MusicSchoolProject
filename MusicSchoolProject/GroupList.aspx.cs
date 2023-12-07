using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GroupList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void GroupsGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        string selectedGroupID = GroupsGridView.SelectedDataKey["groupID"].ToString();
        GetStudentsListByGroupId.SelectParameters["groupID"].DefaultValue = selectedGroupID;
        StudentsList.Visible = true;
        StudentsList.DataBind();
    }

}