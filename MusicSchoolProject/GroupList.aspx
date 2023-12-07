<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="GroupList.aspx.cs" Inherits="GroupList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        p {
            height: 100vh;
            margin-top: 300px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
        <asp:GridView runat="server" DataSourceID="GetGroups" ID="GroupsGridView" AutoGenerateColumns="False" DataKeyNames="groupID" OnSelectedIndexChanged="GroupsGridView_SelectedIndexChanged">
            <Columns>
                <asp:BoundField DataField="groupID" HeaderText="Номер группы" ReadOnly="True" InsertVisible="False" SortExpression="groupID"></asp:BoundField>
                <asp:BoundField DataField="name" HeaderText="Название группы" ReadOnly="True" SortExpression="name"></asp:BoundField>
                <asp:BoundField DataField="admission_year" HeaderText="Год поступления" SortExpression="admission_year"></asp:BoundField>
                <asp:CommandField ShowSelectButton="True"></asp:CommandField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource runat="server" ID="GetGroups" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>" SelectCommand="SELECT groups.groupID, CONCAT(groups.groupID, '_', groups.admission_year) AS name, groups.admission_year FROM groups;"></asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="GetStudentsListByGroupId" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>"
            SelectCommand="SELECT student.name, student.lastname, student.fathername, discipline.name as disName FROM group_student JOIN student ON group_student.studentID = student.studentID JOIN discipline ON discipline.disciplineID = student.disciplineID WHERE group_student.groupID = @groupID;">
            <SelectParameters>
                <asp:Parameter Name="groupID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:ListView Visible="False" runat="server" ID="StudentsList" DataSourceID="GetStudentsListByGroupId">
            <ItemTemplate>
                <div><%# Eval("name") %> - <%# Eval("lastname") %> - <%# Eval("fathername") %> - <%# Eval("disName") %></div>
            </ItemTemplate>
        </asp:ListView>
</asp:Content>

