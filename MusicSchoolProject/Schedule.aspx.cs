using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Schedule : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void WeekDayList_SelectedIndexChanged1(object sender, EventArgs e)
    {
        Session[SessionConsts.SelectedWeekDay] = WeekDayList.SelectedValue;
    }

    protected void TeachersList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionConsts.SelectedTeacherId] = TeachersList.SelectedValue;
    }

    protected void ClearButton_Click(object sender, EventArgs e)
    {
        Session[SessionConsts.SelectedWeekDay] = 0;
        Session[SessionConsts.SelectedTeacherId] = 0;
        TeachersList.ClearSelection();
        WeekDayList.ClearSelection();
    }
}