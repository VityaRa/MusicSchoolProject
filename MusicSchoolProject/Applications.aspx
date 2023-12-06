<%@ Page Title="Заявки" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Applications.aspx.cs" Inherits="Applications" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .application-wrapper {
            display: flex;
            margin-top: 24px;
        }

        .btn-wrapper {
            display: flex;
            align-items: center;
            flex-direction: column;
            justify-content: center;
            margin-left: 16px;
            gap: 8px;
        }

        .auth-button {
            color: #fff;
        }

        .accept {
            background: green !important;
        }
        .danger {
            background: red !important;
        }

        .cancel {
            color: #000;
        }
        .success_msg {
            color: green;
            margin-bottom: 32px;
            font-size: 18px;
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="wrapper">
        <div class="info">
            На данной странице можно просмотреть заявки
        </div>
        <p class="success_msg">
            <asp:Literal runat="server" ID="SuccessMessage" />
        </p>
        <label>
            Выбор статуса заявки
        </label>
        <asp:DropDownList AppendDataBoundItems="true" runat="server" DataSourceID="GetAllApplicationStatuses" ID="ApplicationStatuses" DataTextField="status_text" DataValueField="status_id" AutoPostBack="True" OnSelectedIndexChanged="ApplicationStatuses_SelectedIndexChanged">
            <asp:ListItem Selected="True" Value="-1">Все статусы</asp:ListItem>
        </asp:DropDownList>
        <label>
            Выбор дисциплины
        </label>
        <asp:DropDownList AppendDataBoundItems="true" runat="server" DataSourceID="GetAllDisciplines" ID="DisciplinesList" DataTextField="name" DataValueField="disciplineID" AutoPostBack="True" OnSelectedIndexChanged="DisciplinesList_SelectedIndexChanged">
            <asp:ListItem Selected="False" Value="-1">Все дисциплины</asp:ListItem>
        </asp:DropDownList>

        <asp:Button runat="server" Text="Очистить" ID="ClearButton" OnClick="ClearButton_Click"></asp:Button>

        <asp:GridView
            EmptyDataText="Заявки не найдены"
            runat="server" AutoGenerateColumns="False" DataSourceID="GetApplicationsList" ID="GridView1" AllowSorting="True" AllowPaging="True" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowDataBound="GridView1_RowDataBound">
            <Columns>
                <asp:CommandField ShowSelectButton="True"></asp:CommandField>
                <asp:BoundField DataField="applicationID" HeaderText="Номер заявки" SortExpression="applicationID"></asp:BoundField>
                <asp:BoundField DataField="status_text" HeaderText="Статус заявки" SortExpression="status_text"></asp:BoundField>
                <asp:BoundField DataField="fullname" HeaderText="ФИО" SortExpression="fullname"></asp:BoundField>
                <asp:BoundField DataField="name" HeaderText="Инструмент" SortExpression="name"></asp:BoundField>
                <asp:BoundField DataField="created_at" HeaderText="Дата создания" SortExpression="created_at"></asp:BoundField>
            </Columns>
        </asp:GridView>
        <div class="application-wrapper" runat="server" id="SelectedApplicationData" visible="false">
            <asp:DetailsView ID="CurrentApplicationData" runat="server" DataSourceID="GetSelectedApplicationData" AutoGenerateRows="False" DataKeyNames="applicationID">
                <Fields>
                    <asp:BoundField DataField="applicationID" HeaderText="Номер" ReadOnly="True" InsertVisible="False" SortExpression="applicationID"></asp:BoundField>
                    <asp:BoundField DataField="status_text" HeaderText="Статус" SortExpression="status_text"></asp:BoundField>
                    <asp:BoundField DataField="fullname" HeaderText="ФИО" ReadOnly="True" SortExpression="fullname"></asp:BoundField>
                    <asp:BoundField DataField="created_at" HeaderText="Дата создания" SortExpression="created_at"></asp:BoundField>
                    <asp:BoundField DataField="name" HeaderText="Инструмент" SortExpression="name"></asp:BoundField>
                    <asp:BoundField DataField="birthdate" HeaderText="Дата рождения" SortExpression="birthdate"></asp:BoundField>
                    <asp:BoundField DataField="description" HeaderText="О себе" SortExpression="description"></asp:BoundField>
                </Fields>
            </asp:DetailsView>
            <div class="btn-wrapper">
                <asp:Button CssClass="auth-button accept" runat="server" Text="Принять" ID="Accept" OnClick="Accept_Click"></asp:Button>
                <asp:Button CssClass="auth-button danger" runat="server" Text="Отклонить" ID="Button1" OnClick="Reject_Click"></asp:Button>
                <asp:Button CssClass="auth-button cancel" runat="server" Text="Закрыть" ID="Cancel" OnClick="Cancel_Click"></asp:Button>
            </div>
        </div>

        <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>" SelectCommand="SELECT [status_id], [status_text] FROM [application_status]" ID="GetAllApplicationStatuses"></asp:SqlDataSource>
        <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>" SelectCommand="SELECT [disciplineID], [name] FROM [discipline]" ID="GetAllDisciplines"></asp:SqlDataSource>
        <asp:SqlDataSource runat="server" ID="GetApplicationsList" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>" SelectCommand="SELECT application.applicationID, application_status.status_text, CONCAT(application.name, ' ', application.lastname, ' ', application.fathername) AS fullname, application.created_at, discipline.name, application.birthdate FROM application INNER JOIN discipline ON application.disciplineID = discipline.disciplineID  INNER JOIN application_status ON application_status.status_id = application.status_id WHERE (application.status_id = @__selected_application_status_id) AND (application.disciplineID = @__selected_discipline_id) OR (application.status_id = @__selected_application_status_id) AND (@__selected_discipline_id = - 1) OR (application.disciplineID = @__selected_discipline_id) AND (@__selected_application_status_id = - 1) OR (@__selected_discipline_id = - 1) AND (@__selected_application_status_id = - 1)">
            <SelectParameters>
                <asp:SessionParameter SessionField="__selected_application_status_id" DefaultValue="-1" Name="__selected_application_status_id"></asp:SessionParameter>
                <asp:SessionParameter SessionField="__selected_discipline_id" DefaultValue="-1" Name="__selected_discipline_id"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource runat="server" ID="GetSelectedApplicationData" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>" 
            SelectCommand="SELECT application.applicationID, application_status.status_text, CONCAT(application.name, ' ', application.lastname, ' ', application.fathername) AS fullname, application.created_at, discipline.name, application.birthdate, application.description FROM application INNER JOIN discipline ON application.disciplineID = discipline.disciplineID INNER JOIN application_status ON application_status.status_id = application.status_id WHERE (application.applicationID = @__selected_application_id)">
            <SelectParameters>
                <asp:SessionParameter SessionField="__selected_application_id" Name="__selected_application_id"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

