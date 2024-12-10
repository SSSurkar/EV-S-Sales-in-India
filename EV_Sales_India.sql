-----------------CREATE DATABASE-------------------
CREATE DATABASE EV_Sales_India;

-----------------USE DATABASE----------------------
USE EV_Sales_India;

----------------CREATE TABLES--------------------

CREATE TABLE States (
    StateID INT PRIMARY KEY,          
    StateName VARCHAR(100) NOT NULL,  
    Region VARCHAR(100),              
    Population INT,                   
    Area DECIMAL(10, 2)               
);

CREATE TABLE Manufacturers (
    ManufacturerID INT PRIMARY KEY,           
    ManufacturerName VARCHAR(100) NOT NULL,   
    Country VARCHAR(100),                     
    FoundedYear INT                           
);

CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY,              
    Model VARCHAR(100) NOT NULL,            
    ManufacturerID INT NOT NULL,           
    VehicleType VARCHAR(50),               
    BatteryCapacity DECIMAL(10, 2),        
    Range INT,                            
    Price DECIMAL(10, 2),     
	);

CREATE TABLE ElectricVehicleSales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    VehicleID INT NOT NULL,
    StateID INT NOT NULL,
    SalesDate DATE NOT NULL,
    QuantitySold INT NOT NULL,
    SalePrice DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    StateID INT NOT NULL,               -- Foreign Key to States
    AgeGroup VARCHAR(20) NOT NULL,      -- Age ranges like '18-25', '26-35'
    IncomeLevel VARCHAR(20) NOT NULL,   -- Income levels like 'Low', 'Middle', 'High'
    VehicleOwned INT,                   -- Foreign Key to Vehicles
 
    FOREIGN KEY (StateID) REFERENCES States(StateID),
    FOREIGN KEY (VehicleOwned) REFERENCES Vehicles(VehicleID)
);

CREATE TABLE MaintenanceRecords (
    MaintenanceID INT PRIMARY KEY IDENTITY(1,1),
    VehicleID INT NOT NULL,             -- Foreign Key to Vehicles
    CustomerID INT NOT NULL,            -- Foreign Key to Customers
    ServiceDate DATE NOT NULL,
    IssueReported VARCHAR(255),
    Cost DECIMAL(10, 2) NOT NULL,
    WarrantyClaimed BIT NOT NULL,       -- Yes/No (1/0)

    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE GlobalSales (
    CountryID INT PRIMARY KEY IDENTITY(1,1),
    CountryName VARCHAR(100) NOT NULL,
    Year INT NOT NULL,
    TotalSales INT NOT NULL,
    TotalRevenue DECIMAL(15, 2) NOT NULL,
    LeadingManufacturer VARCHAR(100) NOT NULL
);

---------------------Dispaly All Tables in Database-------------------
SELECT table_name 
FROM information_schema.tables
WHERE table_type = 'BASE TABLE';

---------------------Display Table Structure------------------------
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Vehicles';




ALTER TABLE Vehicles
ADD CONSTRAINT FK_Vehicles_Manufacturers
FOREIGN KEY (ManufacturerID) REFERENCES Manufacturers(ManufacturerID);


ALTER TABLE ElectricVehicleSales
ADD CONSTRAINT FK_VehicleID
FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID);


ALTER TABLE ElectricVehicleSales
ADD CONSTRAINT FK_StateID
FOREIGN KEY (StateID) REFERENCES States(StateID);



INSERT INTO Vehicles (VehicleID, Model, ManufacturerID, VehicleType, BatteryCapacity, Range, Price)
VALUES
(1, 'Tesla Model 3', 1, 'Sedan', 75.00, 350, 5000000),
(2, 'Tesla Model S', 1, 'Sedan', 100.00, 500, 7500000),
(3, 'Tesla Model X', 1, 'SUV', 100.00, 450, 8500000),
(4, 'Tesla Model Y', 1, 'SUV', 75.00, 370, 6500000),
(5, 'Nissan Leaf', 2, 'Hatchback', 40.00, 250, 2500000),
(6, 'Nissan Ariya', 2, 'SUV', 87.00, 400, 3500000),
(7, 'Nissan e-NV200', 2, 'Van', 40.00, 200, 2200000),
(8, 'Chevrolet Bolt EV', 3, 'Hatchback', 66.00, 400, 3000000),
(9, 'Chevrolet Spark EV', 3, 'Hatchback', 21.00, 130, 1500000),
(10, 'Chevrolet Volt', 3, 'Sedan', 18.00, 85, 1800000),
(11, 'BMW i3', 4, 'Hatchback', 33.00, 250, 3500000),
(12, 'BMW i8', 4, 'Coupe', 11.00, 30, 8000000),
(13, 'BMW i4', 4, 'Sedan', 81.00, 350, 5000000),
(14, 'BMW X3 xDrive30e', 4, 'SUV', 12.0, 40, 5500000),
(15, 'Audi e-tron', 5, 'SUV', 95.00, 400, 8000000),
(16, 'Audi Q4 e-tron', 5, 'SUV', 82.00, 370, 5500000),
(17, 'Audi A3 e-tron', 5, 'Sedan', 13.00, 30, 4000000),
(18, 'Mercedes-Benz EQC', 6, 'SUV', 80.00, 400, 9000000),
(19, 'Mercedes-Benz EQS', 6, 'Sedan', 107.00, 770, 12000000),
(20, 'Mercedes-Benz EQA', 6, 'SUV', 66.00, 340, 6000000),
(21, 'Ford Mustang Mach-E', 7, 'SUV', 88.00, 370, 6500000),
(22, 'Ford F-150 Lightning', 7, 'Truck', 130.00, 500, 9500000),
(23, 'Ford Focus Electric', 7, 'Hatchback', 33.00, 185, 2200000),
(24, 'Hyundai Kona Electric', 8, 'SUV', 64.00, 400, 3500000),
(25, 'Hyundai Ioniq 5', 8, 'SUV', 77.00, 480, 4500000),
(26, 'Hyundai Ioniq Electric', 8, 'Hatchback', 38.00, 200, 2500000),
(27, 'Hyundai Nexo', 8, 'SUV', 95.00, 570, 7000000),
(28, 'Jaguar I-PACE', 9, 'SUV', 90.00, 470, 9000000),
(29, 'Jaguar XE', 9, 'Sedan', 14.00, 50, 3500000),
(30, 'Land Rover Defender PHEV', 10, 'SUV', 13.00, 45, 7000000);

SELECT *FROM Vehicles;


INSERT INTO States (StateID, StateName, Region, Population, Area)
VALUES
(1, 'Andhra Pradesh', 'State', 49577103, 162968),
(2, 'Arunachal Pradesh', 'State', 1382611, 83743),
(3, 'Assam', 'State', 31169272, 78438),
(4, 'Bihar', 'State', 104099452, 94163),
(5, 'Chhattisgarh', 'State', 25545198, 135192),
(6, 'Goa', 'State', 1458545, 3702),
(7, 'Gujarat', 'State', 60439692, 196024),
(8, 'Haryana', 'State', 25353081, 44212),
(9, 'Himachal Pradesh', 'State', 6864602, 55673),
(10, 'Jharkhand', 'State', 32988134, 79716),
(11, 'Karnataka', 'State', 61095297, 191791),
(12, 'Kerala', 'State', 33406061, 38863),
(13, 'Madhya Pradesh', 'State', 76935897, 308350),
(14, 'Maharashtra', 'State', 112374333, 307713),
(15, 'Manipur', 'State', 2855794, 22327),
(16, 'Meghalaya', 'State', 2964007, 22429),
(17, 'Mizoram', 'State', 1097206, 21081),
(18, 'Nagaland', 'State', 2383000, 16579),
(19, 'Odisha', 'State', 41974218, 155707),
(20, 'Punjab', 'State', 27704236, 50362),
(21, 'Rajasthan', 'State', 68548437, 342239),
(22, 'Sikkim', 'State', 610577, 7096),
(23, 'Tamil Nadu', 'State', 72147030, 130058),
(24, 'Telangana', 'State', 35676692, 114840),
(25, 'Tripura', 'State', 3671032, 10486),
(26, 'Uttar Pradesh', 'State', 199812341, 243286),
(27, 'Uttarakhand', 'State', 10086292, 53483),
(28, 'West Bengal', 'State', 91276115, 88752),


(29, 'Andaman and Nicobar Islands', 'Union Territory', 380581, 8249),
(30, 'Chandigarh', 'Union Territory', 1055450, 114),
(31, 'Dadra and Nagar Haveli and Daman and Diu', 'Union Territory', 343709, 603),
(32, 'Lakshadweep', 'Union Territory', 64201, 30),
(33, 'Delhi', 'Union Territory', 16787941, 1484),
(34, 'Puducherry', 'Union Territory', 1244464, 492),
(35, 'Ladakh', 'Union Territory', 274289, 59550),
(36, 'Lakshadweep', 'Union Territory', 64201, 30);

SELECT *FROM STATES;


INSERT INTO ElectricVehicleSales (VehicleID, StateID, SalesDate, QuantitySold, SalePrice)
VALUES
(1, 1, '2024-01-01', 10, 500000),  
(2, 2, '2024-01-02', 15, 650000),  
(3, 3, '2024-01-03', 20, 700000),  
(4, 4, '2024-01-04', 8, 720000),   
(5, 5, '2024-01-05', 25, 600000),  
(6, 6, '2024-01-06', 12, 750000),  
(7, 7, '2024-01-07', 18, 680000),  
(8, 8, '2024-01-08', 22, 540000),  
(9, 9, '2024-01-09', 10, 620000),  
(10, 10, '2024-01-10', 14, 710000),
(11, 11, '2024-01-11', 9, 590000), 
(12, 12, '2024-01-12', 11, 650000),
(13, 13, '2024-01-13', 16, 730000), 
(14, 14, '2024-01-14', 13, 710000), 
(15, 15, '2024-01-15', 5, 650000),  
(16, 16, '2024-01-16', 18, 680000), 
(17, 17, '2024-01-17', 22, 590000), 
(18, 18, '2024-01-18', 20, 720000), 
(19, 19, '2024-01-19', 14, 690000), 
(20, 20, '2024-01-20', 25, 740000), 
(21, 21, '2024-01-21', 30, 700000), 
(22, 22, '2024-01-22', 12, 650000), 
(23, 23, '2024-01-23', 15, 610000), 
(24, 24, '2024-01-24', 18, 730000), 
(25, 25, '2024-01-25', 20, 680000), 
(26, 26, '2024-01-26', 10, 750000), 
(27, 27, '2024-01-27', 7, 800000),  
(28, 28, '2024-01-28', 5, 650000), 
(29, 29, '2024-02-01', 15, 500000),  
(30, 30, '2024-02-02', 10, 650000);  

SELECT *FROM ElectricVehicleSales


-- Insert data into Manufacturers table
INSERT INTO Manufacturers (ManufacturerID, ManufacturerName, Country, FoundedYear)
VALUES
(1, 'Tesla', 'USA', 2003),
(2, 'NIO', 'China', 2014),
(3, 'BYD', 'China', 1995),
(4, 'Rivian', 'USA', 2009),
(5, 'Lucid Motors', 'USA', 2007),
(6, 'XPeng Motors', 'China', 2014),
(7, 'Fisker Automotive', 'USA', 2007),
(8, 'Bollinger Motors', 'USA', 2014),
(9, 'Polestar', 'Sweden', 2017),
(10, 'Lordstown Motors', 'USA', 2018),
(11, 'VinFast', 'Vietnam', 2017),
(12, 'Faraday Future', 'USA', 2014),
(13, 'GreenPower Motor Company', 'Canada', 2010),
(14, 'Proterra', 'USA', 2004),
(15, 'Envision AESC', 'Japan', 2007),
(16, 'Nissan', 'Japan', 1933),
(17, 'Volkswagen', 'Germany', 1937),
(18, 'BMW', 'Germany', 1916),
(19, 'Mercedes-Benz', 'Germany', 1926),
(20, 'Ford', 'USA', 1903),
(21, 'Chevrolet', 'USA', 1911),
(22, 'Hyundai', 'South Korea', 1967),
(23, 'Kia', 'South Korea', 1944),
(24, 'Tata Motors', 'India', 1945),
(25, 'Mahindra Electric', 'India', 1997),
(26, 'Toyota', 'Japan', 1937),
(27, 'Audi', 'Germany', 1909),
(28, 'Porsche', 'Germany', 1931),
(29, 'Jaguar Land Rover', 'UK', 2008),
(30, 'Volvo Cars', 'Sweden', 1927);

SELECT *FROM Manufacturers;

--------------------------- Insert Data into Customer Table----------------
INSERT INTO Customers (StateID, AgeGroup, IncomeLevel, VehicleOwned)
VALUES
(1, '18-25', 'Low', 1),
(2, '26-35', 'Middle', 2),
(3, '36-45', 'High', 3),
(4, '46-55', 'Middle', 4),
(5, '56-65', 'Low', 5),
(6, '18-25', 'High', 6),
(7, '26-35', 'Middle', 7),
(8, '36-45', 'High', 8),
(9, '46-55', 'Low', 9),
(10, '56-65', 'Middle', 10),
(11, '18-25', 'High', 11),
(12, '26-35', 'Middle', 12),
(13, '36-45', 'Low', 13),
(14, '46-55', 'High', 14),
(15, '56-65', 'Middle', 15),
(16, '18-25', 'Low', 16),
(17, '26-35', 'High', 17),
(18, '36-45', 'Middle', 18),
(19, '46-55', 'Low', 19),
(20, '56-65', 'High', 20),
(21, '18-25', 'Middle', 21),
(22, '26-35', 'Low', 22),
(23, '36-45', 'High', 23),
(24, '46-55', 'Middle', 24),
(25, '56-65', 'Low', 25),
(26, '18-25', 'High', 26),
(27, '26-35', 'Middle', 27),
(28, '36-45', 'Low', 28),
(29, '46-55', 'High', 29),
(30, '56-65', 'Middle', 30),
(31, '18-25', 'Low', 1),
(32, '26-35', 'High', 2),
(33, '36-45', 'Middle', 3),
(34, '46-55', 'Low', 4),
(35, '56-65', 'High', 5),
(36, '18-25', 'Middle', 6),
(1, '26-35', 'Low', 7),
(2, '36-45', 'High', 8),
(3, '46-55', 'Middle', 9),
(4, '56-65', 'Low', 10),
(5, '18-25', 'High', 11),
(6, '26-35', 'Middle', 12),
(7, '36-45', 'Low', 13),
(8, '46-55', 'High', 14),
(9, '56-65', 'Middle', 15),
(10, '18-25', 'Low', 16),
(11, '26-35', 'High', 17),
(12, '36-45', 'Middle', 18),
(13, '46-55', 'Low', 19),
(14, '56-65', 'High', 20),
(15, '18-25', 'Middle', 21);

SELECT *FROM CUSTOMERS;

--------------------------Insert Records MaintenanceRecords Tables----------------------

INSERT INTO MaintenanceRecords (VehicleID, CustomerID, ServiceDate, IssueReported, Cost, WarrantyClaimed)
VALUES
(1, 69, '2024-01-01', 'Battery Replacement', 3000.00, 1),
(2, 70, '2024-01-02', 'Brake Service', 1500.00, 0),
(3, 71, '2024-01-03', 'Tire Replacement', 2500.00, 1),
(4, 72, '2024-01-04', 'Suspension Repair', 5000.00, 0),
(5, 73, '2024-01-05', 'Air Conditioning Service', 2000.00, 1),
(6, 74, '2024-01-06', 'Engine Overhaul', 15000.00, 0),
(7, 75, '2024-01-07', 'Windshield Repair', 1200.00, 1),
(8, 76, '2024-01-08', 'Transmission Service', 4500.00, 1),
(9, 77, '2024-01-09', 'Oil Change', 800.00, 0),
(10, 78, '2024-01-10', 'Battery Replacement', 3200.00, 1),
(11, 79, '2024-01-11', 'Brake Pad Replacement', 1500.00, 0),
(12, 80, '2024-01-12', 'Suspension Inspection', 2500.00, 1),
(13, 81, '2024-01-13', 'Tire Alignment', 1200.00, 0),
(14, 82, '2024-01-14', 'Fuel Injector Service', 2800.00, 1),
(15, 83, '2024-01-15', 'AC Leak Repair', 1800.00, 0),
(16, 84, '2024-01-16', 'Fuel System Cleaning', 2200.00, 1),
(17, 85, '2024-01-17', 'Clutch Repair', 4000.00, 0),
(18, 86, '2024-01-18', 'Cooling System Service', 3500.00, 1),
(19, 87, '2024-01-19', 'Engine Diagnostic', 2000.00, 0),
(20, 88, '2024-01-20', 'Brake Fluid Replacement', 900.00, 1),
(21, 89, '2024-01-21', 'Exhaust System Repair', 4500.00, 0),
(22, 90, '2024-01-22', 'Headlight Replacement', 1000.00, 1),
(23, 91, '2024-01-23', 'Tire Balancing', 1300.00, 0),
(24, 92, '2024-01-24', 'Battery Terminal Cleaning', 400.00, 1),
(25, 93, '2024-01-25', 'Oil Change', 600.00, 0),
(26, 94, '2024-01-26', 'Timing Belt Replacement', 2500.00, 1),
(27, 95, '2024-01-27', 'Turbocharger Repair', 5000.00, 0),
(28, 96, '2024-01-28', 'Drive Belt Replacement', 2000.00, 1),
(29, 97, '2024-02-01', 'Windshield Wiper Replacement', 600.00, 0),
(30, 98, '2024-02-02', 'Power Steering Fluid Change', 1200.00, 1);

SELECT *FROM MaintenanceRecords;

------------------------------------Insert Records in GlobalSales Table---------------------------

INSERT INTO GlobalSales (CountryName, Year, TotalSales, TotalRevenue, LeadingManufacturer)
VALUES
('USA', 2023, 150000, 1000000000.00, 'Tesla'),
('Germany', 2023, 120000, 800000000.00, 'Volkswagen'),
('China', 2023, 200000, 1500000000.00, 'BYD'),
('India', 2023, 80000, 400000000.00, 'Tata Motors'),
('Japan', 2023, 95000, 600000000.00, 'Toyota'),
('South Korea', 2023, 70000, 350000000.00, 'Hyundai'),
('UK', 2023, 50000, 250000000.00, 'Nissan'),
('France', 2023, 60000, 300000000.00, 'Renault'),
('Italy', 2023, 40000, 200000000.00, 'Fiat'),
('Australia', 2023, 30000, 150000000.00, 'Tesla'),
('Canada', 2023, 55000, 275000000.00, 'Ford'),
('Russia', 2023, 35000, 175000000.00, 'Lada'),
('Brazil', 2023, 45000, 225000000.00, 'Chevrolet'),
('Mexico', 2023, 50000, 250000000.00, 'General Motors'),
('South Africa', 2023, 20000, 100000000.00, 'BMW'),
('Spain', 2023, 65000, 325000000.00, 'Seat'),
('Netherlands', 2023, 30000, 150000000.00, 'Volvo'),
('Belgium', 2023, 20000, 100000000.00, 'Peugeot'),
('Turkey', 2023, 50000, 250000000.00, 'Ford'),
('Sweden', 2023, 25000, 125000000.00, 'Scania'),
('Switzerland', 2023, 15000, 75000000.00, 'Tesla'),
('India', 2022, 75000, 375000000.00, 'Tata Motors'),
('China', 2022, 180000, 1350000000.00, 'BYD'),
('USA', 2022, 130000, 900000000.00, 'Tesla'),
('Germany', 2022, 110000, 700000000.00, 'Volkswagen'),
('Japan', 2022, 100000, 650000000.00, 'Toyota'),
('South Korea', 2022, 68000, 340000000.00, 'Hyundai'),
('Australia', 2022, 28000, 140000000.00, 'Tesla'),
('Mexico', 2022, 46000, 230000000.00, 'General Motors');

SELECT *FROM GlobalSales;

-------------------------------------------------------------------------------------------------------------------------------------------------
--1) get the ev sales for specific year------------

 SELECT *FROM ElectricVehicleSales WHERE YEAR(SALESDATE)=2024;

 --------------------GET THE AVERAGE PRICE OF EV'S SOLD ALL STATES------------------

 SELECT STATEID , AVG(SALEPRICE) AS AVERAGEPRICE FROM ElectricVehicleSales WHERE STATEID=12 GROUP BY STATEID; 


 ------------------ UPDATE SALES PRICE 350000.00 WHERE STATEID = 10------=----------------
 SELECT *FROM ElectricVehicleSales WHERE SaleID=10;
 UPDATE ElectricVehicleSales
SET SalePrice = 350000.00
WHERE SaleID = 10; 

SELECT *FROM ElectricVehicleSales  WHERE SALEID=10;-- Adjust SaleID to target a specific record


 ------------------AVRRAGE PRICE OF EV BY MANIFACTURER--------------------

 SELECT m.ManufacturerName,
 AVG(v.Price) AS AverageVehiclePrice
FROM Vehicles AS v
JOIN Manufacturers AS m 
ON v.ManufacturerID = m.ManufacturerID
GROUP BY m.ManufacturerName;


--------------------GET TOTAL SALES AND REVENUE FOR GOA STATE---------------------

SELECT STATEID=6,SUM(QUANTITYSOLD) AS TOTALSALES,
SUM(QUANTITYSOLD * SALEPRICE) AS TOTALREVENUE 
FROM ELECTRICVEHICLESALES
WHERE STATEID = 6
GROUP BY STATEID;


 --------------------GET THE STATE WITH THE HIGHEST AVERAGE PRICE IN DESC ORDER FOR EVS SALES IN 2024 --------------------

 SELECT TOP 1 S.STATENAME, AVG(EV.SALEPRICE) AS AVERAGE_PRICE
 FROM ElectricVehicleSales  AS EV
 JOIN STATES AS S
 ON EV.StateID = S.StateID
 WHERE YEAR(SALESDATE)=2024 
 GROUP BY S.STATENAME
 ORDER BY AVERAGE_PRICE DESC;

 --------------------Get Top 5 Vehicles with the Highest Sales Quantity------------------------

 SELECT TOP 5 v.Model,
 SUM(ev.QuantitySold) AS TotalQuantitySold
FROM ElectricVehicleSales AS  ev
JOIN Vehicles AS v 
ON ev.VehicleID = v.VehicleID
GROUP BY v.Model
ORDER BY TotalQuantitySold DESC;

-----------------------GET THE TOP 10 VEHICLE MODEL WITH HIGHEST SALES QUANTITY AND PRICE IN 2024 IN DESC ORDER---------------

SELECT V.MODEL, EV.QUANTITYSOLD , SUM(EV.QUANTITYSOLD * SALEPRICE) AS TOTALSALES
FROM ElectricVehicleSales AS EV
JOIN Vehicles AS V 
ON EV.VehicleID = V.VehicleID
WHERE YEAR (EV.SALESDATE) = 2024
GROUP BY V.Model , EV.QuantitySold
ORDER BY TOTALSALES DESC;

------------------------Total Number of Vehicles Sold by State

SELECT StateName, SUM(QuantitySold) AS TotalVehiclesSold
FROM ElectricVehicleSales
JOIN States ON ElectricVehicleSales.StateID = States.StateID
GROUP BY StateName;

-----------------------Average Sales Price of Vehicles in Each State

SELECT StateName, AVG(SalePrice) AS AverageSalePrice
FROM ElectricVehicleSales
JOIN States ON ElectricVehicleSales.StateID = States.StateID
GROUP BY StateName;

--------------------------List of Manufacturers and their Vehicles

SELECT ManufacturerName, Model
FROM Manufacturers
JOIN Vehicles ON Manufacturers.ManufacturerID = Vehicles.ManufacturerID;

-------------------------Sales Quantity for a Specific Vehicle

SELECT Model, SUM(QuantitySold) AS TotalSales
FROM ElectricVehicleSales
JOIN Vehicles ON ElectricVehicleSales.VehicleID = Vehicles.VehicleID
WHERE Model = 'Tesla Model 3'
GROUP BY Model;

-------------------------Number of Vehicles Sold by Region---------------

SELECT Region, SUM(QuantitySold) AS TotalSales
FROM ElectricVehicleSales
JOIN States ON ElectricVehicleSales.StateID = States.StateID
GROUP BY Region;

------------------Medium

----------------------Top 5 States by Total Vehicle Sales

SELECT TOP 5 StateName, SUM(QuantitySold) AS TotalSales
FROM ElectricVehicleSales
JOIN States ON ElectricVehicleSales.StateID = States.StateID
GROUP BY StateNam
ORDER BY TotalSales DESC;

---------------------Total Revenue Generated by Each Manufacturer

SELECT ManufacturerName, SUM(SalePrice * QuantitySold) AS TotalRevenue
FROM ElectricVehicleSales
JOIN Vehicles ON ElectricVehicleSales.VehicleID = Vehicles.VehicleID
JOIN Manufacturers ON Vehicles.ManufacturerID = Manufacturers.ManufacturerID
GROUP BY ManufacturerName;

-------------------------Average Sales per Month for Each Vehicle

SELECT Model, AVG(QuantitySold) AS AverageSalesPerMonth
FROM ElectricVehicleSales
JOIN Vehicles ON ElectricVehicleSales.VehicleID = Vehicles.VehicleID
GROUP BY Model;

-----------------------Sales by State and Vehicle Type

SELECT StateName, VehicleType, SUM(QuantitySold) AS SalesQuantity
FROM ElectricVehicleSales
JOIN States ON ElectricVehicleSales.StateID = States.StateID
JOIN Vehicles ON ElectricVehicleSales.VehicleID = Vehicles.VehicleID
GROUP BY StateName, VehicleType
ORDER BY SalesQuantity DESC;

----------------------advance 

----------------------Top 3 States with the Highest Average Vehicle Price

SELECT TOP 3 StateName, AVG(SalePrice) AS AveragePrice
FROM ElectricVehicleSales
JOIN States ON ElectricVehicleSales.StateID = States.StateID
GROUP BY StateName
ORDER BY AveragePrice DESC;

----------------------Most Popular Vehicle by Region

SELECT Region, Model, SUM(QuantitySold) AS TotalSales
FROM ElectricVehicleSales
JOIN States ON ElectricVehicleSales.StateID = States.StateID
JOIN Vehicles ON ElectricVehicleSales.VehicleID = Vehicles.VehicleID
GROUP BY Region, Model
ORDER BY TotalSales DESC;

------------------------Vehicle Sales Correlation with State Population

SELECT StateName, SUM(QuantitySold) AS TotalSales, Population, 
       SUM(QuantitySold) * 1.0 / Population AS SalesPerCapita
FROM ElectricVehicleSales
JOIN States ON ElectricVehicleSales.StateID = States.StateID
GROUP BY StateName, Population;























