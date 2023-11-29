<%@ Page Title="Оставить заявку" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Account_Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

    <div class="form-horizontal">
        <asp:ValidationSummary runat="server" CssClass="text-danger" />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="UserName" CssClass="col-md-2 control-label">Имя</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="UserName" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName"
                    CssClass="text-danger" ErrorMessage="Имя обязательно для заполнения." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="LastName" CssClass="col-md-2 control-label">Фамилия</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="LastName" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="LastName"
                    CssClass="text-danger" ErrorMessage="Фамилия обязательна для заполнения." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="FatherName" CssClass="col-md-2 control-label">Отчество</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="FatherName" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="FatherName"
                    CssClass="text-danger" ErrorMessage="Отчетство обязательно для заполнения." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Address" CssClass="col-md-2 control-label">Адрес проживания</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Address" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Address"
                    CssClass="text-danger" ErrorMessage="Адрес должен быть заполнен." />
            </div>
        </div>
        
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="InstumentDisciplinesList" CssClass="col-md-2 control-label">Инструмент</asp:Label>
            <asp:DropDownList runat="server" DataSourceID="GetInstumentDisciplines" ID="InstumentDisciplinesList" DataTextField="name" DataValueField="disciplineID"></asp:DropDownList><asp:SqlDataSource runat="server" ID="GetInstumentDisciplines" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>" SelectCommand="SELECT * FROM [discipline] WHERE ([isIndividual] = @isIndividual)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="true" Name="isIndividual" Type="Boolean"></asp:Parameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </div>

        <%--        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Пароль</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                    CssClass="text-danger" ErrorMessage="Поле пароля обязательно для заполнения." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label">Подтверждение пароля</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="Поле подтверждения пароля обязательно для заполнения." />
                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="Пароль и подтверждение пароля не совпадают." />
            </div>
        </div>--%>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" OnClick="CreateUser_Click" Text="Отправить заявку" CssClass="btn btn-default" />
            </div>
        </div>
    </div>
</asp:Content>
