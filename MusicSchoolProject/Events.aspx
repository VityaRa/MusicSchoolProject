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

        <asp:SqlDataSource runat="server" ID="GetEventsList" ConnectionString="<%$ ConnectionStrings:musicConnectionString %>"
            SelectCommand="SELECT *, event_type.type_name as event_name FROM events JOIN event_type ON events.type_id = event_type.type_id;"></asp:SqlDataSource>
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

