CREATE DATABASE AutoService;

USE AutoService;

CREATE TABLE CarBrands (
	BrandId INT IDENTITY(1, 1) PRIMARY KEY,
	BrandName NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE CarModels (
	ModelId INT IDENTITY(1, 1) PRIMARY KEY,
	BrandId INT NOT NULL,
	ModelName NVARCHAR(50) NOT NULL UNIQUE,
	EngineVolume FLOAT NOT NULL,
	CONSTRAINT FK_Models_Brands FOREIGN KEY (BrandId) REFERENCES CarBrands(BrandId),
	CONSTRAINT UQ_BrandModel UNIQUE (BrandId, ModelName)
);

CREATE TABLE Clients (
	ClientId INT IDENTITY(1, 1) PRIMARY KEY,
	FullName NVARCHAR(100) NOT NULL,
	Phone NVARCHAR(20) NOT NULL UNIQUE,
	Address NVARCHAR(200) NOT NULL,
    PassportData NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Masters (
    MasterID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20) NOT NULL UNIQUE,
    Experience INT NOT NULL CHECK (Experience >= 0)
);

CREATE TABLE Cars (
    CarID INT IDENTITY(1,1) PRIMARY KEY,
    ModelID INT NOT NULL,
    LicensePlate NVARCHAR(15) NOT NULL UNIQUE,
    ClientID INT NOT NULL,
    Mileage INT NOT NULL CHECK (Mileage >= 0),
    CONSTRAINT FK_Cars_Models FOREIGN KEY (ModelID) REFERENCES CarModels(ModelID),
    CONSTRAINT FK_Cars_Clients FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);

CREATE TABLE Repairs (
    RepairID INT IDENTITY(1,1) PRIMARY KEY,
    CarID INT NOT NULL,
    MasterID INT NOT NULL,
    FaultDescription NVARCHAR(500) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NULL,
    Cost DECIMAL(10, 2) NOT NULL CHECK (Cost >= 0),
    CONSTRAINT FK_Repairs_Cars FOREIGN KEY (CarID) REFERENCES Cars(CarID),
    CONSTRAINT FK_Repairs_Masters FOREIGN KEY (MasterID) REFERENCES Masters(MasterID),
    CONSTRAINT CHK_EndDate CHECK (EndDate IS NULL OR EndDate >= StartDate)
);



INSERT INTO CarBrands (BrandName) VALUES 
('Toyota'), ('Honda'), ('BMW'), ('Mercedes'), ('Audi'),
('Ford'), ('Volkswagen'), ('Hyundai'), ('Kia'), ('Nissan'),
('Lexus'), ('Mazda'), ('Subaru'), ('Volvo'), ('Chevrolet');

INSERT INTO CarModels (BrandID, ModelName, EngineVolume) VALUES
(1, 'Camry', 2.5), (1, 'Corolla', 1.8), (1, 'RAV4', 2.0),
(2, 'Accord', 2.4), (2, 'Civic', 1.5), (2, 'CR-V', 1.6),
(3, 'X5', 3.0), (3, '320i', 2.0), (3, '520d', 2.0),
(4, 'E-Class', 2.0), (4, 'S-Class', 3.0), (4, 'GLC', 2.0),
(5, 'A4', 2.0), (5, 'A6', 3.0), (5, 'Q5', 2.0),
(6, 'Focus', 2.0), (6, 'Mondeo', 2.5), (6, 'Explorer', 3.5),
(7, 'Golf', 1.4), (7, 'Passat', 2.0), (7, 'Tiguan', 2.0),
(8, 'Solaris', 1.6), (8, 'Tucson', 2.0), (8, 'Santa Fe', 2.4),
(9, 'Rio', 1.6), (9, 'Sportage', 2.0), (9, 'Sorento', 2.5),
(10, 'Qashqai', 2.0), (10, 'X-Trail', 2.5), (10, 'Murano', 3.5),
(11, 'RX', 3.5), (11, 'NX', 2.0), (11, 'ES', 3.5),
(12, 'CX-5', 2.5), (12, '6', 2.5), (12, '3', 2.0),
(13, 'Forester', 2.5), (13, 'Outback', 2.5), (13, 'XV', 2.0),
(14, 'XC90', 2.0), (14, 'S60', 2.0), (14, 'XC60', 2.0),
(15, 'Cruze', 1.6), (15, 'Captiva', 2.4), (15, 'Tahoe', 5.3);

INSERT INTO Clients (FullName, Phone, Address, PassportData) VALUES
('Ivanov I.I.', '+79111111111', 'Lenina, 1', '1111 111111'),
('Petrov P.P.', '+79112222222', 'Gagarina, 2', '2222 222222'),
('Sidorov S.S.', '+79113333333', 'Pushkina, 3', '3333 333333'),
('Kuznetsov K.K.', '+79114444444', 'Mira, 4', '4444 444444'),
('Smirnov S.S', '+79115555555', 'Sunshine, 5', '5555 555555'),
('Fedorov F.F.', '+79116666666', 'Lesnaya, 6', '6666 666666'),
('Egorov E.E.', '+79117777777', 'Sadovaya, 7', '7777 777777'),
('Grigoriev G.G.', '+79118888888', 'Zelenaya, 8', '8888 888888'),
('Orlov O.O.', '+79119999999', 'Gornaya, 9', '9999 999999'),
('Borisov B.B.', '+79110000000', 'Rechnaya, 10', '0000 000000'),
('Pavlov P.P.', '+79121111111', 'Vesennaya, 11', '1111 111112'),
('Semenov S.S.', '+79122222222', 'Letnyaya, 12', '2222 222223'),
('Mikhailov M.M.', '+79123333333', 'Zimnyaya, 13', '3333 333334'),
('Romanov R.R.', '+79124444444', 'Osennaya, 14', '4444 444445'),
('Andreev A.A.', '+79125555555', 'Severnaya, 15', '5555 555556'),
('Tarasov T.T.', '+79126666666', 'Yuzhnaya, 16', '6666 666667'),
('Sergeev S.S.', '+79127777777', 'Zapadnaya, 17', '7777 777778'),
('Filippov F.F.', '+79128888888', 'Vostochnaya, 18', '8888 888889'),
('Alekseev A.A.', '+79129999999', 'Tsentralnaya, 19', '9999 999990'),
('Denisov D.D.', '+79130000000', 'Okruzhnaya, 20', '0000 000001');

INSERT INTO Masters (FullName, Phone, Experience) VALUES
('Vasiliev V.V.', '+79211111111', 5),
('Nikolaev N.N.', '+79212222222', 10),
('Dmitriev D.D.', '+79213333333', 3),
('Aleksandrov A.A', '+79214444444', 7),
('Popov P.P.', '+79215555555', 12),
('Sokolov S.S.', '+79216666666', 8),
('Lebedev L.L.', '+79217777777', 6),
('Kozlov K.K.', '+79218888888', 4),
('Novikov N.N.', '+79219999999', 9),
('Morozov M.M.', '+79220000000', 11),
('Pavlov P.P.', '+79221111111', 2),
('Vinogradov V.V.', '+79222222222', 7),
('Bogdanov B.B.', '+79223333333', 10),
('Voronov V.V.', '+79224444444', 5),
('Gusev G.G.', '+79225555555', 12),
('Titov T.T.', '+79226666666', 3),
('Kuzmin K.K.', '+79227777777', 6),
('Krylov K.K.', '+79228888888', 8),
('Savelyev S.S.', '+79229999999', 4),
('Efimov E.E.', '+79230000000', 9);

INSERT INTO Cars (ModelID, LicensePlate, ClientID, Mileage) VALUES
(1, 'A111AA777', 1, 50000),
(4, 'B222BB777', 2, 80000),
(7, 'C333CC777', 3, 120000),
(10, 'E444EE777', 4, 60000),
(13, 'K555KK777', 5, 90000),
(2, 'M666MM777', 1, 45000),
(5, 'H777HH777', 2, 55000),
(8, 'P888PP777', 3, 75000),
(3, 'T999TT777', 6, 30000),
(6, 'Y888YY777', 7, 65000),
(9, 'U777UU777', 8, 85000),
(12, 'I666II777', 9, 95000),
(15, 'O555OO777', 10, 110000),
(16, 'L444LL777', 11, 40000),
(19, 'J333JJ777', 12, 50000),
(22, 'G222GG777', 13, 70000),
(25, 'F111FF777', 14, 80000),
(28, 'D999DD777', 15, 100000),
(17, 'S888SS777', 6, 45000),
(20, 'R777RR777', 7, 55000),
(23, 'W666WW777', 8, 75000),
(26, 'Q555QQ777', 9, 85000),
(29, 'Z444ZZ777', 10, 95000),
(18, 'X333XX777', 11, 60000),
(21, 'V222VV777', 12, 70000),
(24, 'N111NN777', 13, 80000),
(27, 'B999BB777', 14, 90000),
(30, 'C888CC777', 15, 120000),
(1, 'D777DD777', 6, 55000),
(4, 'E666EE777', 7, 65000),
(7, 'F555FF777', 8, 85000),
(10, 'G444GG777', 9, 95000),
(13, 'H333HH777', 10, 105000);

INSERT INTO Repairs (CarID, MasterID, FaultDescription, StartDate, EndDate, Cost) VALUES
(1, 1, 'Change oil and filters', '2023-05-01', '2023-05-02', 5000),
(2, 2, 'KPP', '2023-05-03', NULL, 15000),
(3, 3, 'Replacing brake pads', '2023-05-05', '2023-05-06', 8000),
(4, 4, 'Engine diagnostics', '2023-05-10', NULL, 3000),
(5, 5, 'Timing Belt Replacement', '2023-05-12', '2023-05-15', 12000),
(6, 1, 'Chassis repair', '2023-05-15', NULL, 10000),
(7, 2, 'Replacing shock absorbers', '2023-05-18', NULL, 9000),
(8, 3, 'Electronics repair', '2023-05-20', NULL, 7000),
(1, 4, 'Replacing spark plugs', '2023-04-01', '2023-04-02', 4000),
(2, 5, 'Gearbox fluid replacement', '2023-04-05', '2023-04-06', 6000),
(9, 6, 'Wheel alignment', '2025-05-22', '2025-05-23', 2500),
(10, 7, 'Replacing the fuel pump', '2025-05-24', NULL, 7500),
(11, 8, 'Suspension repair', '2025-05-25', '2025-05-27', 11000),
(12, 9, 'Air conditioning repair', '2025-05-26', NULL, 8500),
(13, 10, 'Replacing the generator', '2025-05-28', '2025-05-29', 9500),
(14, 11, 'Brake system diagnostics', '2025-05-30', NULL, 3000),
(15, 12, 'Replacing the starter', '2024-06-01', '2024-06-02', 6500),
(16, 13, 'Replacing the radiator', '2024-06-03', NULL, 8000),
(17, 14, 'Replacing the battery', '2024-06-05', '2024-06-05', 5000),
(18, 15, 'Replacing the exhaust system', '2025-06-06', NULL, 12000),
(19, 1, 'Replacing the ignition coil', '2024-04-10', '2024-04-11', 4500),
(20, 2, 'Replacing the fuel filter', '2024-04-12', '2024-04-12', 3500),
(21, 3, 'Replacing the air filter', '2024-04-15', '2024-04-15', 2000),
(22, 4, 'Replacing the cabin filter', '2024-04-18', '2024-04-18', 2500),
(23, 5, 'Replacing the timing belt', '2024-04-20', '2024-04-22', 13000),
(24, 6, 'Replacing the water pump', '2024-04-25', '2024-04-26', 8500),
(25, 7, 'Replacing the thermostat', '2023-04-28', '2023-04-29', 6000),
(26, 8, 'Replacing the oil pump', '2023-05-02', '2023-05-03', 9500),
(27, 9, 'Replacing the power steering pump', '2025-05-05', '2025-05-06', 7500),
(28, 10, 'Replacing the turbocharger', '2025-05-08', '2025-05-10', 18000),
(29, 11, 'Replacing the injectors', '2025-05-12', '2025-05-13', 11000),
(30, 12, 'Replacing the glow plugs', '2025-05-15', '2025-05-16', 5000),
(1, 13, 'Replacing the oxygen sensor', '2023-03-01', '2023-03-02', 4500),
(2, 14, 'Replacing the mass air flow sensor', '2023-03-05', '2023-03-06', 4000),
(3, 15, 'Replacing the throttle body', '2023-03-10', '2023-03-11', 6500),
(4, 1, 'Replacing the ABS module', '2023-03-15', '2023-03-16', 9500),
(5, 2, 'Replacing the wheel bearing', '2023-03-20', '2023-03-21', 7500),
(6, 3, 'Replacing the CV joint', '2024-03-25', '2024-03-26', 8500),
(7, 4, 'Replacing the drive shaft', '2024-03-30', '2024-03-31', 11000),
(8, 5, 'Replacing the differential', '2024-04-05', '2024-04-07', 15000);




CREATE FUNCTION GetMasterWorkloadPercentage
(
    @MasterID INT,
    @Year INT,
    @Month INT
)
RETURNS DECIMAL(5, 2)
AS
BEGIN
    DECLARE @MasterWorkload DECIMAL(10, 2)
    DECLARE @TotalWorkload DECIMAL(10, 2)
    DECLARE @Percentage DECIMAL(5, 2)
    
    SELECT @MasterWorkload = SUM(Cost)
    FROM Repairs
    WHERE MasterID = @MasterID
      AND YEAR(StartDate) = @Year
      AND MONTH(StartDate) = @Month
      AND EndDate IS NULL
    
    SELECT @TotalWorkload = SUM(Cost)
    FROM Repairs
    WHERE YEAR(StartDate) = @Year
      AND MONTH(StartDate) = @Month
      AND EndDate IS NULL
    
    IF @TotalWorkload = 0 OR @TotalWorkload IS NULL
        SET @Percentage = 0
    ELSE
        SET @Percentage = (@MasterWorkload / @TotalWorkload) * 100
    
    RETURN @Percentage
END;




CREATE VIEW MayUnfinishedRepairsWithTotals AS
SELECT 
    m.FullName AS MasterName,
    cb.BrandName AS CarBrand,
    cm.ModelName AS CarModel,
    c.LicensePlate,
    cl.FullName AS ClientName,
    r.FaultDescription,
    r.StartDate,
    r.Cost,
    SUM(r.Cost) OVER (PARTITION BY m.MasterID) AS MasterTotal,
    SUM(r.Cost) OVER () AS GrandTotal
FROM 
    AutoService.dbo.Repairs r
    INNER JOIN Masters m ON r.MasterID = m.MasterID
    INNER JOIN Cars c ON r.CarID = c.CarID
    INNER JOIN CarModels cm ON c.ModelID = cm.ModelID
    INNER JOIN CarBrands cb ON cm.BrandId = cb.BrandId
    INNER JOIN Clients cl ON c.ClientID = cl.ClientID
WHERE 
    YEAR(r.StartDate) = 2025 AND 
    MONTH(r.StartDate) = 5 AND 
    r.EndDate IS NULL;


ALTER VIEW MayUnfinishedRepairsWithTotals AS
SELECT 
    m.FullName AS MasterName,
    cb.BrandName AS CarBrand,
    cm.ModelName AS CarModel,
    c.LicensePlate,
    cl.FullName AS ClientName,
    r.FaultDescription,
    r.StartDate,
    r.Cost,
    SUM(r.Cost) OVER (PARTITION BY m.MasterID) AS MasterTotal,
    SUM(r.Cost) OVER () AS GrandTotal,
    dbo.GetMasterWorkloadPercentage(m.MasterID, YEAR(r.StartDate), MONTH(r.StartDate)) AS WorkloadPercentage
FROM 
    AutoService.dbo.Repairs r
    INNER JOIN Masters m ON r.MasterID = m.MasterID
    INNER JOIN Cars c ON r.CarID = c.CarID
    INNER JOIN CarModels cm ON c.ModelID = cm.ModelID
    INNER JOIN CarBrands cb ON cm.BrandId = cb.BrandId
    INNER JOIN Clients cl ON c.ClientID = cl.ClientID
WHERE 
    YEAR(r.StartDate) = 2025 AND 
    MONTH(r.StartDate) = 5 AND 
    r.EndDate IS NULL;


CREATE VIEW UnfinishedRepairsWithTotals AS
SELECT 
    m.FullName AS MasterName,
    cb.BrandName AS CarBrand,
    cm.ModelName AS CarModel,
    c.LicensePlate,
    cl.FullName AS ClientName,
    r.FaultDescription,
    r.StartDate,
    r.Cost,
    SUM(r.Cost) OVER (PARTITION BY m.MasterID) AS MasterTotal,
    SUM(r.Cost) OVER () AS GrandTotal
FROM 
    AutoService.dbo.Repairs r
    INNER JOIN Masters m ON r.MasterID = m.MasterID
    INNER JOIN Cars c ON r.CarID = c.CarID
    INNER JOIN CarModels cm ON c.ModelID = cm.ModelID
    INNER JOIN CarBrands cb ON cm.BrandId = cb.BrandId
    INNER JOIN Clients cl ON c.ClientID = cl.ClientID
WHERE r.EndDate IS NULL;