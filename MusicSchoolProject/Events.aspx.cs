using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Events : System.Web.UI.Page
{
    private string DEFAULT_LIST_TITLE = "Список учеников-участников";
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
        if (!IsPostBack)
        {
            var roleId = GetRole();

            bool shouldShowCommandField = roleId == 3 || roleId == 2;

            ctl00.Columns[0].Visible = shouldShowCommandField;
        }
    }

    protected void ClearButton_Click(object sender, EventArgs e)
    {
        StartTimeDropDown.ClearSelection();
        EventTypes.ClearSelection();
        MonthDropDown.ClearSelection();

        GetEventsList.SelectParameters["__selected_event_type"].DefaultValue = "0";
        GetEventsList.SelectParameters["__selected_start_time"].DefaultValue = "00:00:00";
        GetEventsList.SelectParameters["__selected_month"].DefaultValue = "0";

        participantsWrapper.Visible = false;
        //listTitle.Visible = false;
        listTitleLiteral.Text = "";
        listTitleLiteral.Visible = false;
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

    protected void ctl00_SelectedIndexChanged(object sender, EventArgs e)
    {
        // Получите выбранный идентификатор мероприятия из GridView
        int eventId = Convert.ToInt32(ctl00.SelectedDataKey.Value);

        // Установите параметр для фильтрации по идентификатору мероприятия в источнике данных DetailsView
        GetStudentsForEvent.SelectParameters["eventId"].DefaultValue = eventId.ToString();
        GetPossibleParticipants.SelectParameters["eventId"].DefaultValue = eventId.ToString();

        // Покажите DetailsView
        participantsWrapper.Visible = true;

        string eventName = ctl00.SelectedRow.Cells[1].Text;
        listTitleLiteral.Text = GetListTitle(eventName);
    }

    private string GetListTitle(string eventName)
    {
        return DEFAULT_LIST_TITLE + ": " + eventName;
    }

    protected void OnAddEventParticipantClick(object sender, EventArgs e)
    {
        int selectedUserId = Convert.ToInt32(StudentDropDown.SelectedValue);
        int selectedEventId = Convert.ToInt32(ctl00.SelectedDataKey.Value);

        if (selectedUserId > 0)
        {
            RequestHelper.AddStudentByIdToEvent(selectedUserId, selectedEventId);
        }
    }
}