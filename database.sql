-- Database creation script for Placement Dashboard
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'PlacementDB')
BEGIN
    CREATE DATABASE PlacementDB;
END
GO

USE PlacementDB;
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Students')
BEGIN
    CREATE TABLE Students (
        StudentID INT IDENTITY(1,1) PRIMARY KEY,
        StudentName VARCHAR(100) NOT NULL,
        Department VARCHAR(50) NULL,
        CompanyName VARCHAR(100) NULL,
        Package DECIMAL(18,2) NULL,
        PlacementStatus VARCHAR(30) NULL
    );

    INSERT INTO Students (StudentName, Department, CompanyName, Package, PlacementStatus) VALUES
    ('Rahul Sharma', 'Computer Engineering', 'TCS', 4.50, 'Placed'),
    ('Amit Patel', 'IT', 'Infosys', 5.00, 'Placed'),
    ('Priya Singh', 'Computer Engineering', 'Wipro', 4.00, 'Placed'),
    ('Neha Verma', 'Mechanical', 'Not Selected', 0.00, 'Not Placed'),
    ('Rohit Kumar', 'IT', 'Accenture', 6.00, 'Placed');
END
GO
