
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

namespace PlacementDashboard
{
    public partial class _Default : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["PlacementDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            // CrystalReportViewer does not retain its ReportSource between postbacks.
            ReportDocument report = Session["PlacementReport"] as ReportDocument;
            if (report != null)
            {
                CrystalReportViewer1.ReportSource = report;
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"INSERT INTO Students
                (StudentName, Department, CompanyName, Package, PlacementStatus)
                VALUES
                (@name, @department, @company, @package, @status)";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@name", txtName.Text);
                cmd.Parameters.AddWithValue("@department", txtDepartment.Text);
                cmd.Parameters.AddWithValue("@company", txtCompany.Text);
                cmd.Parameters.AddWithValue("@package", Convert.ToDecimal(txtPackage.Text));
                cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            LoadData();
        }



        void LoadData()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // Total Students
                SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Students", con);
                lblTotal.Text = cmd.ExecuteScalar().ToString();

                // Placed Students
                cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Students WHERE PlacementStatus='Placed'", con);
                lblPlaced.Text = cmd.ExecuteScalar().ToString();

                // Not Placed Students
                cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Students WHERE PlacementStatus='Not Placed'", con);
                lblNotPlaced.Text = cmd.ExecuteScalar().ToString();

                // Placement Percentage
                int total = Convert.ToInt32(lblTotal.Text);
                int placed = Convert.ToInt32(lblPlaced.Text);

                double percentage = total > 0
                    ? (placed * 100.0) / total
                    : 0;

                lblPercentage.Text = percentage.ToString("F2") + "%";

                // Highest Package
                cmd = new SqlCommand(
                    "SELECT ISNULL(MAX(Package), 0) FROM Students", con);

                lblHighestPackage.Text =
                    Convert.ToDecimal(cmd.ExecuteScalar()).ToString("F2") + " LPA";

                // Display Student Records
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT * FROM Students", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvStudents.DataSource = dt;
                gvStudents.DataBind();
            }
        }

        protected void gvStudents_SelectedIndexChanged(object sender, EventArgs e)
        {
            int studentId = Convert.ToInt32(
                gvStudents.SelectedDataKey.Value);

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT * FROM Students WHERE StudentID=@id", con);

                da.SelectCommand.Parameters.AddWithValue("@id", studentId);

                DataTable dt = new DataTable();
                da.Fill(dt);

                dvStudent.DataSource = dt;
                dvStudent.DataBind();
            }
        }

        protected void btnReport_Click(object sender, EventArgs e)
        {
            try
            {
                ReportDocument previousReport = Session["PlacementReport"] as ReportDocument;
                if (previousReport != null)
                {
                    previousReport.Close();
                    previousReport.Dispose();
                }

                ReportDocument report = new ReportDocument();

                report.Load(Server.MapPath("~/PlacementReport.rpt"));

                // The report was designed against the local database. Supply the
                // current data explicitly so Crystal does not try to use stale
                // designer credentials or prompt for a database logon.
                using (SqlConnection con = new SqlConnection(cs))
                using (SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Students", con))
                {
                    DataTable students = new DataTable();
                    da.Fill(students);
                    report.SetDataSource(students);
                }

                Session["PlacementReport"] = report;
                CrystalReportViewer1.ReportSource = report;
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" +
                    ex.Message.Replace("'", "") +
                    "');</script>");
            }
        }
    }
}