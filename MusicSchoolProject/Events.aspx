<%@ Page Title="Мероприятия" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Events.aspx.cs" Inherits="Events" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .test {
            height: 100vh;
        }

        .image img {
            width: 100px;
            height: auto;
        }

        .application-wrapper {
            display: flex;
            margin-top: 24px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="test">
        <label>
            Выбор месяца
        </label>
        <asp:DropDownList AppendDataBoundItems="true" runat="server" ID="MonthDropDown" AutoPostBack="True" OnSelectedIndexChanged="MonthDropDown_SelectedIndexChanged">
            <asp:ListItem Selected="True" Value="0">Все</asp:ListItem>
            <asp:ListItem Value="1">Январь</asp:ListItem>
            <asp:ListItem Value="2">Февраль</asp:ListItem>
            <asp:ListItem Value="3">Март</asp:ListItem>
            <asp:ListItem Value="4">Апрель</asp:ListItem>
            <asp:ListItem Value="5">Май</asp:ListItem>
            <asp:ListItem Value="6">Июнь</asp:ListItem>
            <asp:ListItem Value="7">Июль</asp:ListItem>
            <asp:ListItem Value="8">Август</asp:ListItem>
            <asp:ListItem Value="9">Сентябрь</asp:ListItem>
            <asp:ListItem Value="10">Октябрь</asp:ListItem>
            <asp:ListItem Value="11">Ноябрь</asp:ListItem>
            <asp:ListItem Value="12">Декабрь</asp:ListItem>
        </asp:DropDownList>


        <label>
            Выбор типа
        </label>
        <asp:DropDownList AppendDataBoundItems="true" runat="server" DataSourceID="GetEventTypes" ID="EventTypes" DataTextField="type_name" DataValueField="type_id" AutoPostBack="True" OnSelectedIndexChanged="EventTypes_SelectedIndexChanged">
            <asp:ListItem Selected="True" Value="0">Все</asp:ListItem>
        </asp:DropDownList>

        <label>
            Время начала
        </label>
        <asp:DropDownList AppendDataBoundItems="true" runat="server" DataSourceID="GetAllStartTimes" ID="StartTimeDropDown" DataTextField="start_time" DataValueField="start_time" AutoPostBack="True" OnSelectedIndexChanged="StartTimeDropDown_SelectedIndexChanged">
            <asp:ListItem Selected="True" Value="00:00:00">Все</asp:ListItem>
        </asp:DropDownList>

        <asp:Button runat="server" Text="Очистить" OnClick="ClearButton_Click" ID="ClearButton"></asp:Button>

        <asp:SqlDataSource runat="server" ID="WeekDayList_1" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>" SelectCommand="SELECT [weekdayID], [name] FROM [week_day]"></asp:SqlDataSource>
        <asp:SqlDataSource runat="server" ID="GetEventTypes" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>" SelectCommand="SELECT * FROM event_type"></asp:SqlDataSource>
        <asp:SqlDataSource runat="server" ID="GetAllStartTimes" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>" SelectCommand="SELECT DISTINCT start_time from events"></asp:SqlDataSource>
        <asp:SqlDataSource runat="server" ID="GetAvailableStudentsToAdd" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>" SelectCommand="SELECT * FROM from student WHERE student.studentID"></asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="GetEventsList" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>"
            SelectCommand="SELECT *, event_type.type_name as event_name FROM events JOIN event_type ON events.type_id = event_type.type_id WHERE (@__selected_start_time = events.start_time OR @__selected_start_time = '00:00:00') AND (@__selected_event_type = events.type_id OR @__selected_event_type = 0) AND (@__selected_month = 0 OR MONTH(events.date) = @__selected_month);">
            <SelectParameters>
                <asp:Parameter Name="__selected_start_time" Type="String" DefaultValue="00:00:00" />
                <asp:Parameter Name="__selected_event_type" Type="Int32" DefaultValue="0" />
                <asp:Parameter Name="__selected_month" Type="Int32" DefaultValue="0" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView runat="server" DataSourceID="GetEventsList" ID="ctl00" AutoGenerateColumns="False" DataKeyNames="eventId" OnSelectedIndexChanged="ctl00_SelectedIndexChanged">
            <Columns>
                <asp:CommandField SelectText="Выбрать" ShowSelectButton="True"></asp:CommandField>
                <asp:BoundField DataField="description" HeaderText="Название" SortExpression="description"></asp:BoundField>
                <asp:BoundField DataField="event_name" HeaderText="Тип"></asp:BoundField>
                <asp:BoundField DataField="date" DataFormatString="{0:D}" HeaderText="Дата проведения" SortExpression="date"></asp:BoundField>
                <asp:BoundField HeaderText="Время начала" DataField="start_time">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField HeaderText="Время конца" DataField="end_time">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:BoundField>
                <asp:ImageField DataImageUrlField="previewUrl">
                    <ItemStyle CssClass="image" Width="30px"></ItemStyle>
                </asp:ImageField>

            </Columns>
            <EmptyDataTemplate>
                Мероприятия отсутствуют
            </EmptyDataTemplate>
        </asp:GridView>

        <div visible="false" runat="server" id="participantsWrapper">
            <h3 id="listTitle" runat="server">
                <asp:Literal runat="server" ID="listTitleLiteral">
                    Список учеников-участников
                </asp:Literal>
            </h3>
            <asp:ListView runat="server" ID="StudentsList" DataSourceID="GetStudentsForEvent" DataKeyNames="studentID">
                <ItemTemplate>
                    <li>
                        <%# Eval("name") + " " %> <%# Eval("lastname") + " " %> <%# Eval("fathername") %>
                    </li>
                </ItemTemplate>
                <EmptyDataTemplate>
                    Пока никто из учеников не участвует
                </EmptyDataTemplate>

            </asp:ListView>
            <asp:DropDownList DataTextField="fullname" DataValueField="studentID" AppendDataBoundItems="true" DataSourceID="GetPossibleParticipants" runat="server" ID="StudentDropDown" AutoPostBack="true">
                <asp:ListItem Value="0">Выберите студента</asp:ListItem>
            </asp:DropDownList>
            <asp:Button Text="Назначить ученика" ID="AddParticipantButton" runat="server" OnClick="OnAddEventParticipantClick" />
        </div>

        <asp:SqlDataSource runat="server" ID="GetStudentsForEvent" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>"
            SelectCommand="SELECT student.studentID, student.name, student.lastname, student.fathername FROM student INNER JOIN events_student ON student.studentID = events_student.student_id WHERE events_student.event_id = @eventId;">
            <SelectParameters>
                <asp:Parameter Name="eventId" Type="Int32" DefaultValue="0" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="GetPossibleParticipants" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>"
            SelectCommand="SELECT studentID, CONCAT(name, ' ', lastname, ' ', fathername) AS fullname FROM student WHERE studentID NOT IN (SELECT student_id FROM events_student WHERE event_id = @eventId);">
            <SelectParameters>
                <asp:Parameter Name="eventId" Type="Int32" DefaultValue="0" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>

</asp:Content>

