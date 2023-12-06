using System;
using System.Web.UI;
public partial class Account_Register : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SuccessMessage.Visible = false;

    }
    private ApplicationModel GetData()
    {
        return new ApplicationModel
        {
            name = UserName.Text,
            lastname = LastName.Text,
            fathername = FatherName.Text,
            address = Address.Text,
            birthdate = Convert.ToDateTime(Birthdate.Text),
            email = Email.Text,
            disciplineID = Convert.ToInt32(InstumentDisciplinesList.SelectedValue),
            description = AboutDescription.Text,
            created_at = DateTime.Now,
            password = Password.Text,
            status_id = 1,
        };
        
    }

    private void OnSuccessRegistration() 
    {
        SuccessMessage.Visible = true;
        FormContent.Visible = false;
    }
    protected void CreateApplication_Click(object sender, EventArgs e)
    {
        ApplicationModel applicationData = GetData();
        RequestHelper.InsertApplication(applicationData);
        OnSuccessRegistration();
    }
}