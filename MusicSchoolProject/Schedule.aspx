<%@ Page Title="Расписание"  MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Schedule.aspx.cs" Inherits="Schedule" %>

<asp:Content ID="ScheduleStyleContent" ContentPlaceHolderID="head" runat="server">
 <style>
    .wrapper {
        width: 100% !important;
        height: 400px;
    }

    .item {
        width: fit-content;
        text-align: left;
        min-width: 10rem;
    }
    
    .header {
        text-align: center;
        padding: 0 1rem;
    }

    .info {
        padding-bottom: 32px;
    }
 </style>
</asp:Content>

<asp:Content ID="ScheduleContent" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="wrapper">
        <div class="info">
            На данной странице вы можете выбрать нужного преподавателя или день недели
        </div>
        <label>
            Выбор дня
        </label>
        <asp:DropDownList runat="server" DataSourceID="WeekDayList_1" ID="WeekDayList" DataTextField="name" DataValueField="weekdayID" AutoPostBack="True" OnSelectedIndexChanged="WeekDayList_SelectedIndexChanged1"></asp:DropDownList>
         <label>
            Выбор преподавателя
        </label>
        <asp:DropDownList AppendDataBoundItems="true" runat="server" DataSourceID="SqlTeacherList" ID="TeachersList" DataTextField="fullname" DataValueField="teacherID" AutoPostBack="True" OnSelectedIndexChanged="TeachersList_SelectedIndexChanged">
            <asp:ListItem Selected="True" Value="-1">Все</asp:ListItem>
        </asp:DropDownList>

        <asp:Button runat="server" Text="Очистить" OnClick="ClearButton_Click" ID="ClearButton">
        </asp:Button>
        
        <asp:SqlDataSource runat="server" ID="WeekDayList_1" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>" SelectCommand="SELECT [weekdayID], [name] FROM [week_day]"></asp:SqlDataSource>
        <asp:SqlDataSource runat="server" ID="SqlTeacherList" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>" SelectCommand="SELECT DISTINCT teacher.teacherID, CONCAT(teacher.name, ' ', teacher.lastname, ' ', teacher.fathername) AS fullname FROM teacher INNER JOIN groups ON groups.teacherID = teacher.teacherID"></asp:SqlDataSource>
       
            <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>" SelectCommand="SELECT week_day.name AS week_day, teacher.fathername, teacher.lastname, teacher.name, teacher.teacherID FROM group_class INNER JOIN groups ON group_class.groupID = groups.groupID INNER JOIN teacher ON groups.teacherID = teacher.teacherID INNER JOIN week_day ON group_class.weekdayID = week_day.weekdayID WHERE 
        ((week_day.weekdayID = @__selected_week_day) OR (@__selected_week_day = 0)) AND ((teacher.teacherID = @__selected_teacher_id) OR (@__selected_teacher_id = 0))" ID="WeekDayAndTeacher">
        <SelectParameters>
            <asp:SessionParameter SessionField="__selected_week_day" DefaultValue="0" Name="__selected_week_day"></asp:SessionParameter>
            <asp:SessionParameter SessionField="__selected_teacher_id" DefaultValue="0" Name="__selected_teacher_id"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>

        <asp:GridView runat="server" AutoGenerateColumns="False" DataSourceID="WeekDayAndTeacher" ID="GridView1" AllowSorting="True">
            <Columns>
                <asp:BoundField HeaderStyle-CssClass="header" ItemStyle-CssClass="item" DataField="week_day" HeaderText="День недели" SortExpression="week_day">
                    <ItemStyle Font-Bold="True"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField HeaderStyle-CssClass="header" ItemStyle-CssClass="item" DataField="name" HeaderText="Имя" SortExpression="name"></asp:BoundField>
                <asp:BoundField HeaderStyle-CssClass="header" ItemStyle-CssClass="item" DataField="lastname" HeaderText="Фамилия" SortExpression="lastname"></asp:BoundField>
                <asp:BoundField HeaderStyle-CssClass="header" ItemStyle-CssClass="item" DataField="fathername" HeaderText="Отчество" SortExpression="fathername"></asp:BoundField>
            </Columns>
        </asp:GridView>
    </div>

</asp:Content>

