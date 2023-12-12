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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="test">

        <%--               <label>
            Выбор дня
        </label>
        <asp:DropDownList runat="server" DataSourceID="WeekDayList_1" ID="WeekDayList" DataTextField="name" DataValueField="weekdayID" AutoPostBack="True" OnSelectedIndexChanged="WeekDayList_SelectedIndexChanged1"></asp:DropDownList>--%>
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

        <asp:SqlDataSource runat="server" ID="GetEventsList" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>"
            SelectCommand="SELECT *, event_type.type_name as event_name FROM events JOIN event_type ON events.type_id = event_type.type_id WHERE (@__selected_start_time = events.start_time OR @__selected_start_time = '00:00:00') AND (@__selected_event_type = events.type_id OR @__selected_event_type = 0) AND (@__selected_month = 0 OR MONTH(events.date) = @__selected_month);">
            <SelectParameters>
                <asp:Parameter Name="__selected_start_time" Type="String" DefaultValue="00:00:00" />
                <asp:Parameter Name="__selected_event_type" Type="Int32" DefaultValue="0" />
                <asp:Parameter Name="__selected_month" Type="Int32" DefaultValue="0" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView runat="server" DataSourceID="GetEventsList" ID="ctl00" AutoGenerateColumns="False" DataKeyNames="eventId">
            <Columns>
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
        </asp:GridView>
    </div>

</asp:Content>

