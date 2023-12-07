<%@ Page Title="Оставить заявку" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Account_Register" %>

<asp:Content ID="RegisterStyleContent" ContentPlaceHolderID="head" runat="server">
    <style>
        .success_msg {
            color: green;
            margin-bottom: 32px;
            font-size: 18px;
            font-weight: bold;
        }
    </style>
</asp:Content>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>
    <asp:Label CssClass="success_msg" ID="SuccessMessage" Visible="false" runat="server" Text="Заявка отправлена администратору"></asp:Label>
    <div class="form-horizontal" runat="server" id="FormContent">
        <asp:ValidationSummary runat="server" CssClass="text-danger" />

        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label">Почта*</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                    CssClass="text-danger" ErrorMessage="Почта должна быть заполнена" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Пароль*</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Password" CssClass="form-control" TextMode="Password" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                    CssClass="text-danger" ErrorMessage="Пароль должна быть заполнен" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label">Подтвердите пароль*</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="ConfirmPassword" CssClass="form-control" TextMode="Password" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" ErrorMessage="Подтверждение пароля должно быть заполнено" />
                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" ErrorMessage="Пароли не совпадают" Operator="Equal" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="UserName" CssClass="col-md-2 control-label">Имя*</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="UserName" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName"
                    CssClass="text-danger" ErrorMessage="Имя обязательно для заполнения." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="LastName" CssClass="col-md-2 control-label">Фамилия*</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="LastName" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="LastName"
                    CssClass="text-danger" ErrorMessage="Фамилия обязательна для заполнения." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="FatherName" CssClass="col-md-2 control-label">Отчество*</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="FatherName" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="FatherName"
                    CssClass="text-danger" ErrorMessage="Отчество обязательно для заполнения." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Address" CssClass="col-md-2 control-label">Адрес проживания*</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Address" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Address"
                    CssClass="text-danger" ErrorMessage="Адрес должен быть заполнен." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Birthdate" CssClass="col-md-2 control-label">Дата рождения*</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Birthdate" CssClass="form-control" TextMode="Date" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Birthdate"
                    CssClass="text-danger" ErrorMessage="Введите дату рождения." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="InstumentDisciplinesList" CssClass="col-md-2 control-label">Инструмент*</asp:Label>
            <asp:DropDownList runat="server" DataSourceID="GetInstumentDisciplines" ID="InstumentDisciplinesList" DataTextField="name" DataValueField="disciplineID"></asp:DropDownList>
            <asp:SqlDataSource runat="server" ID="GetInstumentDisciplines" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>" SelectCommand="SELECT * FROM [discipline] WHERE ([isIndividual] = @isIndividual)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="true" Name="isIndividual" Type="Boolean"></asp:Parameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
       <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="AboutDescription" CssClass="col-md-2 control-label">О себе</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="AboutDescription" CssClass="form-control" TextMode="MultiLine" MaxLength="200" />
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" OnClick="CreateApplication_Click" Text="Отправить заявку" CssClass="btn btn-default" />
            </div>
        </div>
    </div>
</asp:Content>
