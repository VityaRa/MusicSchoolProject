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
        Session["__selected_week_day"] = WeekDayList.SelectedValue;
    }

    protected void TeachersList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["__selected_teacher_id"] = TeachersList.SelectedValue;
    }

    protected void ClearButton_Click(object sender, EventArgs e)
    {
        Session["__selected_teacher_id"] = 0;
        Session["__selected_week_day"] = 0;
        TeachersList.ClearSelection();
        WeekDayList.ClearSelection();
    }
}