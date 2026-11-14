# College Placement Dashboard

An ASP.NET Web Forms application designed to track and manage student placement details, calculate placement statistics, and generate detailed Crystal Reports.

## Features
- **Placement Metrics**: Real-time overview of Total Students, Placed Students, Not Placed Students, Placement Percentage, and Highest Package (LPA).
- **Student Registration**: Simple form to register new student placement details (Student Name, Department, Company Name, Package in LPA, Placement Status).
- **Placement Records Table**: Interactive `GridView` showing all recorded student entries with detailed record selection.
- **Crystal Report Integration**: Embedded Crystal Reports viewer with export (PDF, Excel, Word) and print capabilities.

## Tech Stack
- **Framework**: ASP.NET Web Forms (.NET Framework 4.7.2)
- **Database**: Microsoft SQL Server LocalDB (`MSSQLLocalDB`)
- **Reporting**: SAP Crystal Reports for Visual Studio
- **UI / Frontend**: Bootstrap 5, jQuery

## Database Setup
1. Open SQL Server Management Studio (SSMS) or connect to `(LocalDB)\MSSQLLocalDB`.
2. Run the provided script `database.sql` to create `PlacementDB` and the `Students` table with sample data.

## Running the Application
1. Open `PlacementDashboard.slnx` in Visual Studio.
2. Restore NuGet packages if prompted.
3. Press **F5** or run with IIS Express.
4. The dashboard will launch at `http://localhost:50683/` or `https://localhost:44354/`.
5. - Collaborated with Subham
   - <!-- collab update -->
