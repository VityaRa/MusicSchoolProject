<%@ Page Title="Персональная информация" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Personal.aspx.cs" Inherits="PersonalPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:FormView runat="server" ID="StudentDetailsFormView" DataSourceID="GetStudentData"
        OnItemCommand="StudentDetailsFormView_ItemCommand" OnModeChanging="StudentDetailsFormView_ModeChanging" OnItemUpdating="StudentDetailsFormView_ItemUpdating">
        <ItemTemplate>
            <p>
                Имя: <%# Eval("name") %>
            </p>
            <p>
                Фамилия: <%# Eval("lastname") %>
            </p>
            <p>
                Отчество: <%# Eval("fathername") %>
            </p>
            <p>
                Дата рождения: <%# Eval("birthdate") %>
            </p>
            <p>
                Адрес: <%# Eval("address") %>
            </p>
            <p>
                Дисциплина: <%# Eval("discipline_name") %>
            </p>
            <p>
                Пароль: <%# Eval("password") %>
            </p>
            <p>
                Email: <%# Eval("email") %>
            </p>
            <asp:Button runat="server" Text="Редактировать" CommandName="Edit" />
        </ItemTemplate>
        <EditItemTemplate>
            <p>
                Имя:
            <asp:TextBox runat="server" ID="txtName" Text='<%# Bind("name") %>' />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName"
                    Display="Dynamic" ErrorMessage="Имя обязательно для заполнения." />
            </p>
            <p>
                Фамилия:
            <asp:TextBox runat="server" ID="txtLastname" Text='<%# Bind("lastname") %>' />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLastname"
                    Display="Dynamic" ErrorMessage="Фамилия обязательна для заполнения." />
            </p>
            <p>
                Отчество:
            <asp:TextBox runat="server" ID="txtFathername" Text='<%# Bind("fathername") %>' />
            </p>
            <p>
                Дата рождения:
            <asp:TextBox runat="server" ID="txtBirthdate" Text='<%# Bind("birthdate") %>' ReadOnly="true" />
            </p>
            <p>
                Адрес:
            <asp:TextBox runat="server" ID="txtAddress" Text='<%# Bind("address") %>' />
            </p>
            <p>
                Дисциплина:
            <asp:TextBox runat="server" ID="txtDiscipline" Text='<%# Bind("name") %>' ReadOnly="true" />
            </p>
            <p>
                Пароль:
            <asp:TextBox runat="server" ID="txtPassword" Text='<%# Bind("password") %>' />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword"
                    Display="Dynamic" ErrorMessage="Пароль обязателен для заполнения." />
            </p>
            <p>
                Email:
            <asp:TextBox runat="server" ID="txtEmail" Text='<%# Bind("email") %>' />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail"
                    Display="Dynamic" ErrorMessage="Email обязателен для заполнения." />
                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail"
                    Display="Dynamic" ErrorMessage="Неверный формат email."
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
            </p>
            <asp:Button runat="server" Text="Обновить" CommandName="Update" />
            <asp:Button runat="server" Text="Отмена" CommandName="Cancel" />
        </EditItemTemplate>
    </asp:FormView>

    <asp:SqlDataSource runat="server" ID="GetStudentData" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>"
        SelectCommand="SELECT student.name, student.lastname, student.fathername, student.birthdate, student.address, discipline.name AS discipline_name, credentials.password, credentials.email FROM student JOIN discipline ON discipline.disciplineID = student.disciplineID JOIN credentials ON credentials.userId = student.studentID WHERE student.studentID = @UserID"
        UpdateCommand="
         UPDATE student SET name = @name, lastname = @lastname, fathername = @fathername, address = @address WHERE studentID = @UserID; UPDATE credentials SET password = @password, email = @email WHERE userId = @UserID;">
        <SelectParameters>
            <asp:Parameter Name="UserID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="lastname" Type="String" />
            <asp:Parameter Name="fathername" Type="String" />
            <asp:Parameter Name="address" Type="String" />
            <asp:Parameter Name="password" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="UserID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

