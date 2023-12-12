using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Events : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ClearButton_Click(object sender, EventArgs e)
    {
        StartTimeDropDown.ClearSelection();
        EventTypes.ClearSelection();

        GetEventsList.SelectParameters["__selected_event_type"].DefaultValue = "0";
        GetEventsList.SelectParameters["__selected_start_time"].DefaultValue = "00:00:00";
    }

    protected void StartTimeDropDown_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetEventsList.SelectParameters["__selected_start_time"].DefaultValue = StartTimeDropDown.SelectedValue;

    }

    protected void EventTypes_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetEventsList.SelectParameters["__selected_event_type"].DefaultValue = EventTypes.SelectedValue;
    }

    protected void MonthDropDown_SelectedIndexChanged(object sender, EventArgs e)
    {
        // Установите выбранный месяц в параметры для фильтрации
        GetEventsList.SelectParameters["__selected_month"].DefaultValue = MonthDropDown.SelectedValue;
        // Обновите данные GridView
        ctl00.DataBind();
    }

}