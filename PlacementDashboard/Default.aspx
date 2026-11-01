
<%@ Page Title="Placement Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PlacementDashboard._Default" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="container mt-4">

    <h2 class="text-center text-primary">College Placement Dashboard</h2>
    <hr />

    <div class="row mb-4">
        <div class="col-md-4">
            <div class="card bg-primary text-white p-3">
                <h5>Total Students</h5>
                <h2><asp:Label ID="lblTotal" runat="server" Text="0"/></h2>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card bg-success text-white p-3">
                <h5>Placed Students</h5>
                <h2><asp:Label ID="lblPlaced" runat="server" Text="0"/></h2>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card bg-dark text-white p-3">
                <h5>Not Placed</h5>
                <h2><asp:Label ID="lblNotPlaced" runat="server" Text="0"/></h2>
            </div>
        </div>
    </div>
    
<div class="row mb-4">
    <div class="col-md-6">
        <div class="card bg-info text-white p-3">
            <h5>Placement Percentage</h5>
            <h2>
                <asp:Label ID="lblPercentage" runat="server" Text="0%" />
            </h2>
        </div>
    </div>

    <div class="col-md-6">
        <div class="card bg-warning text-dark p-3">
            <h5>Highest Package</h5>
            <h2>
                <asp:Label ID="lblHighestPackage" runat="server" Text="0 LPA" />
            </h2>
        </div>
    </div>
</div>


    <h4>Add Student Placement Details</h4>

    <div class="row">
        <div class="col-md-6 mb-3">
            <label>Student Name</label>
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control"/>
        </div>

        <div class="col-md-6 mb-3">
            <label>Department</label>
            <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control"/>
        </div>

        <div class="col-md-6 mb-3">
            <label>Company Name</label>
            <asp:TextBox ID="txtCompany" runat="server" CssClass="form-control"/>
        </div>

        <div class="col-md-6 mb-3">
            <label>Package (LPA)</label>
            <asp:TextBox ID="txtPackage" runat="server" CssClass="form-control"/>
        </div>

        <div class="col-md-6 mb-3">
            <label>Placement Status</label>
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                <asp:ListItem>Placed</asp:ListItem>
                <asp:ListItem>Not Placed</asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>

    <asp:Button ID="btnAdd" runat="server" Text="Add Student"
        CssClass="btn btn-success" OnClick="btnAdd_Click"/>

    <hr />

    <h4>Student Placement Records</h4>

  
<asp:GridView ID="gvStudents" runat="server"
    AutoGenerateColumns="True"
    CssClass="table table-bordered table-striped"
    DataKeyNames="StudentID"
    AutoGenerateSelectButton="True"
    OnSelectedIndexChanged="gvStudents_SelectedIndexChanged">
</asp:GridView>

    <h4 class="mt-4">Student Details</h4>

  <asp:DetailsView ID="dvStudent" runat="server"
    AutoGenerateRows="True"
    CssClass="table table-bordered"
    Height="50px" Width="100%">
</asp:DetailsView>

<asp:Button ID="btnReport" runat="server"
    Text="Generate Crystal Report"
    CssClass="btn btn-primary mt-3"
    OnClick="btnReport_Click" />

<hr />

<h4>Crystal Report</h4>

<div class="card p-3 shadow-sm mb-5" style="overflow-x: auto; background-color: #ffffff;">
    <CR:CrystalReportViewer
        ID="CrystalReportViewer1"
        runat="server"
        AutoDataBind="false"
        EnableDatabaseLogonPrompt="false"
        EnableParameterPrompt="false"
        ToolPanelView="None"
        Width="100%"
        Height="650px" />
</div>

</div>

</asp:Content> 
