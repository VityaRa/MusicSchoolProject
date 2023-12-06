using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Applications : System.Web.UI.Page
{
    //TODO: add role logic
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void ClearButton_Click(object sender, EventArgs e)
    {
        Session[SessionConsts.SelectedDisciplineId] = -1;
        Session[SessionConsts.SelectedApplicationStatusId] = -1;

        ApplicationStatuses.ClearSelection();
        DisciplinesList.ClearSelection();
        HideActiveApplication();
    }

    protected void ApplicationStatuses_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionConsts.SelectedApplicationStatusId] = ApplicationStatuses.SelectedValue;
    }

    protected void DisciplinesList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session[SessionConsts.SelectedDisciplineId] = DisciplinesList.SelectedValue;
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selectedApplicationId = Convert.ToInt32(GridView1.SelectedRow.Cells[1].Text);
        Session[SessionConsts.SelectedApplicationId] = selectedApplicationId;
        SelectedApplicationData.Visible = true;
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // Проверьте значение поля
            string fieldValue = DataBinder.Eval(e.Row.DataItem, "status_text").ToString();

            if (fieldValue != "Ожидание")
            {
                int selectButtonIndex = GridView1.Columns.IndexOf(GridView1.Columns.OfType<CommandField>().FirstOrDefault(f => f.ShowSelectButton));

                if (selectButtonIndex >= 0)
                {
                    LinkButton selectButton = e.Row.Cells[selectButtonIndex].Controls[0] as LinkButton;

                    if (selectButton != null)
                    {
                        selectButton.Visible = false;
                    }
                }
            }
        }
    }

    private void ShowSuccessMessage(string message)
    {
        SuccessMessage.Visible = true;
        SuccessMessage.Text = message;
    }
    private void OnSuccessAccept()
    {
        HideActiveApplication();
        ShowSuccessMessage("Заявка одобрена, ученик создан");
    }
    protected void Accept_Click(object sender, EventArgs e)
    {
        var applicationToAcceptId = Convert.ToInt32(Session[SessionConsts.SelectedApplicationId]);
        var applicationToAccept = RequestHelper.GetApplicationByID(applicationToAcceptId);
        var userToCreate = ModelHelper.GetUserDataFromApplication(applicationToAccept);
        var createdStudentId = RequestHelper.CreateStudent(userToCreate);
        Credentials creds = new Credentials
        {
            email = applicationToAccept.email,
            password = applicationToAccept.password,
            userId = createdStudentId,
            roleId = (int)Consts.Roles.Student,
        };
        RequestHelper.CreateCreds(creds);
        RequestHelper.MarkApplicationAccepted(applicationToAcceptId);
        OnSuccessAccept();
    }

    protected void Reject_Click(object sender, EventArgs e)
    {

    }

    private void HideActiveApplication ()
    {
        Session[SessionConsts.SelectedApplicationId] = -1;
        SelectedApplicationData.Visible = false;
    }
    protected void Cancel_Click(object sender, EventArgs e)
    {
        HideActiveApplication();
    }
}