DROP DATABASE IF EXISTS grab;
CREATE DATABASE grab;
USE grab;

--
-- Table GrabUser
--
CREATE TABLE `GrabUser`(
	`GrabID` varchar(15) NOT NULL,
    `FirstName` varchar(50) NOT NULL,
    `LastName` varchar(50) NOT NULL,
    `Phone` varchar(50) NOT NULL,
    `Email` varchar(50) NOT NULL,
    `Address` varchar(50) NOT NULL,
    `DOB` date NOT NULL,
    
    PRIMARY KEY(`GrabID`)
);

LOCK TABLES `GrabUser` WRITE;
INSERT INTO `GrabUser` VALUES
-- Customer
('G118', 'Alice', 'Johnson', '1234567890', 'alicejohnson@gmail.com', '123 Main Street', '1990-05-15'),
('G119', 'Bob', 'Smith', '9876543210', 'bobsmith@gmail.com', '456 Oak Avenue', '1985-08-21'),
('G120', 'Charlie', 'Brown', '5551234567', 'charliebrown@gmail.com', '789 Pine Road', '1992-03-18'),
('G121', 'Diana', 'Miller', '9998887777', 'dianamiller@gmail.com', '234 Maple Drive', '1998-12-30'),
('G122', 'Eva', 'Davis', '1112223333', 'evadavis@gmail.com', '567 Birch Lane', '1987-09-09'),
('G123', 'Viet', 'Nguyen', '1234567890', 'vietnguyen@gmail.com', '12 Abbey Road', '2000-03-12'),
('G124', 'Anna', 'Smith', '9876543210', 'annasmith@gmail.com', '45 Main Street', '1995-08-21'),
('G125', 'John', 'Doe', '5551234567', 'johndoe@gmail.com', '78 Elm Avenue', '1988-11-05'),
('G126', 'Emily', 'Johnson', '9998887777', 'emilyjohnson@gmail.com', '34 Oak Lane', '1992-07-17'),
('G127', 'Michael', 'Williams', '1112223333', 'michaelwilliams@gmail.com', '56 Pine Street', '1985-04-03'),
-- Driver
('G128', 'Sophia', 'Brown', '7776665555', 'sophiabrown@gmail.com', '89 Maple Drive', '1999-09-09'),
('G129', 'Daniel', 'Miller', '3334445555', 'danielmiller@gmail.com', '23 Cedar Road', '1990-12-30'),
('G130', 'Olivia', 'Anderson', '4445556666', 'oliviaanderson@gmail.com', '67 Birch Street', '1997-02-14'),
('G131', 'Ethan', 'White', '2223334444', 'ethanwhite@gmail.com', '78 Willow Lane', '1994-06-28'),
('G132', 'Isabella', 'Davis', '6667778888', 'isabelladavis@gmail.com', '45 Spruce Avenue', '1987-10-11'),
('G133', 'George', 'Anderson', '3334445555', 'georgeanderson@gmail.com', '890 Elm Street', '1994-06-28'),
('G134', 'Hannah', 'White', '4445556666', 'hannahwhite@gmail.com', '123 Willow Lane', '1997-02-14'),
('G135', 'Ian', 'Black', '6667778888', 'ianblack@gmail.com', '456 Cedar Road', '1996-11-05'),
('G136', 'Jasmine', 'Taylor', '2223334444', 'jasminetaylor@gmail.com', '789 Spruce Avenue', '1995-04-03'),
('G137', 'Kevin', 'Moore', '7776665555', 'kevinmoore@gmail.com', '234 Pine Street', '1999-10-11');
UNLOCK TABLES;

--
-- Table Customer
--
CREATE TABLE `Customer`(
	`CID` varchar(15) NOT NULL,
	`CustomerType` varchar(15) NOT NULL,
    
	PRIMARY KEY(CID),
	FOREIGN KEY (CID) REFERENCES GrabUser(GrabID) ON DELETE CASCADE
);

LOCK TABLES `Customer` WRITE;
INSERT INTO `Customer` VALUES
('G118', 'Gold'),
('G119', 'Platinum'),
('G120', 'Silver'),
('G121', 'Ordinary'),
('G122', 'Gold'),
('G123', 'Gold'),
('G124', 'Platinum'),
('G125', 'Silver'),
('G126', 'Ordinary'),
('G127', 'Gold');
UNLOCK TABLES;

--
-- Table Driver
--
CREATE TABLE Driver(
	`DID` varchar(15) NOT NULL,
	`TIN` varchar(50) NOT NULL,
	`DLNo` varchar(50) NOT NULL,
	`DLExpiry` date NOT NULL,
    
	PRIMARY KEY(DID),
	FOREIGN KEY (DID) REFERENCES GrabUser(GrabID) ON DELETE CASCADE
);

LOCK TABLE `Driver` WRITE;
INSERT INTO `Driver` VALUES
('G128', 123456789101029, '012394949293', '2027-09-20'),
('G129', 987654321202030, '098765432109', '2024-05-15'),
('G130', 456789012303041, '567890123456', '2023-11-10'),
('G131', 789012345404052, '234567890123', '2025-08-03'),
('G132', 567890123505063, '345678901234', '2026-12-28'),
('G133', 123456789101029, '012394949293', '2027-09-20'),
('G134', 987654321202030, '098765432109', '2024-05-15'),
('G135', 456789012303041, '567890123456', '2023-11-10'),
('G136', 789012345404052, '234567890123', '2025-08-03'),
('G137', 567890123505063, '345678901234', '2026-12-28');
UNLOCK TABLES;

--
-- Table Vehicle
--
CREATE TABLE Vehicle(
	`VID` varchar(15) NOT NULL,
	`DID` varchar(15) NOT NULL,
    `VehicleType` varchar(50) NOT NULL,
	`Model` varchar(50) NOT NULL,
	`Color` varchar(20) NOT NULL,
	`Active` varchar(18) NOT NULL,
	`Condition` varchar(15) NOT NULL,
	`Capacity` int NOT NULL,
	`InsuranceNo` varchar(15) NOT NULL,
	`InsuranceExpiry` varchar(15) NOT NULL,
	`LastChecked` date NOT NULL,
    
	PRIMARY KEY(VID),
	FOREIGN KEY (DID) REFERENCES Driver(DID) ON DELETE CASCADE
);

LOCK TABLE `Vehicle` WRITE;
INSERT INTO `Vehicle` VALUES
('V550', 'G128', 'Bike', 'Honda Wave Alpha', 'Black', 'true', 'Good', 2, 'I23019092', '2030-03-19', '2021-10-23'),
('V551', 'G129', 'Car', 'Toyota Camry', 'Silver', 'true', 'Average', 4, 'I98765432', '2029-08-15', '2022-01-05'),
('V552', 'G130', 'Bike', 'Honda Vision', 'Red', 'false', 'Bad', 2, 'I34567890', '2028-05-28', '2021-12-12'),
('V553', 'G131', 'Car', 'Vios', 'Blue', 'true', 'Good', 7, 'I23456789', '2027-11-10', '2021-11-30'),
('V554', 'G132', 'Bike', 'Honda Vision', 'White', 'true', 'Average', 2, 'I87654321', '2029-04-14', '2022-02-18'),
('V555', 'G133', 'Bike', 'Honda SH', 'Black', 'true', 'Good', 2, 'I23019092', '2030-03-19', '2021-10-23'),
('V556', 'G134', 'Car', 'Toyota Camry', 'Silver', 'true', 'Average', 4, 'I98765432', '2029-08-15', '2022-01-05'),
('V557', 'G135', 'Bike', 'Vision', 'Red', 'false', 'Bad', 2, 'I34567890', '2028-05-28', '2021-12-12'),
('V558', 'G136', 'Car', 'Toyota Innova', 'Blue', 'true', 'Good', 7, 'I23456789', '2027-11-10', '2021-11-30'),
('V559', 'G137', 'Bike', 'Honda Vision', 'White', 'true', 'Average', 2, 'I87654321', '2029-04-14', '2022-02-18');
UNLOCK TABLES;

--
-- Table PaymentMethod
--
CREATE TABLE PaymentMethod (
	`PayID` varchar(15) NOT NULL,
    `PaymentType` enum('Cash', 'Card') NOT NULL,
    `CashReferenceNo` varchar(50),
	`CardNo` varchar(16),
	`CVV` varchar(3),
	`ExpiryDate` DATE,
	`CardType` varchar(50),
	`BillingAdd` varchar(50),
    
	PRIMARY KEY(PayID)
);

LOCK TABLE `PaymentMethod` WRITE;
INSERT INTO `PaymentMethod` VALUES
('P001', 'Cash', 'CRN12345', NULL, NULL, NULL, NULL, NULL),
('P002', 'Card', NULL, '1234567890123456', '789', '2023-12-31', 'Visa', '123 Main Street'),
('P003', 'Card', NULL, '9876543210987654', '456', '2024-09-30', 'MasterCard', '456 Oak Avenue'),
('P004', 'Card', NULL, '1111222233334444', '123', '2025-06-15', 'American Express', '789 Pine Road'),
('P005', 'Cash', 'CRN67890', NULL, NULL, NULL, NULL, NULL),
('P006', 'Card', NULL, '5555666677778888', '234', '2022-08-20', 'Discover', '890 Elm Street'),
('P007', 'Card', NULL, '8765432109876543', '567', '2026-04-25', 'Visa', '567 Birch Lane'),
('P008', 'Cash', 'CRN54321', NULL, NULL, NULL, NULL, NULL),
('P009', 'Card', NULL, '9999888877776666', '789', '2023-05-12', 'MasterCard', '234 Maple Drive'),
('P010', 'Cash', 'CRN11111', NULL, NULL, NULL, NULL, NULL);
UNLOCK TABLES;

--
-- Table TripRequests
--
CREATE TABLE TripRequests (
	`TripID` varchar(15) NOT NULL,
	`CID` varchar(15) NOT NULL,
	`DID` varchar(15) NOT NULL,
	`TripType` varchar(50) NOT NULL,
	`PickupLoc` varchar(50) NOT NULL,
	`DropoffLoc` varchar(50) NOT NULL,
	`Distance` float NOT NULL,
	`EstFare` float NOT NULL,
	`PayID` varchar(15) NOT NULL,
    
	PRIMARY KEY(TripID),
	FOREIGN KEY (PayID) REFERENCES PaymentMethod(PayID) ON DELETE CASCADE,
	FOREIGN KEY (CID) REFERENCES Customer(CID) ON DELETE CASCADE,
	FOREIGN KEY (DID) REFERENCES Driver(DID) ON DELETE CASCADE
);

LOCK TABLE `TripRequests` WRITE;
INSERT INTO `TripRequests` VALUES
('T10101', 'G123', 'G128', 'Economy', '5 Main Street', '18 Pine Avenue', 8.2, 12000, 'P002'),
('T10102', 'G124', 'G131', 'Plus', '22 Elm Lane', '45 Birch Road', 14.7, 20000, 'P003'),
('T10103', 'G125', 'G132', 'Standard', '12 Abbey Road', '32 Wall Street', 4.5, 15000, 'P005'),
('T10104', 'G126', 'G129', 'Economy', '34 Maple Drive', '67 Cedar Street', 6.8, 11000, 'P007'),
('T10105', 'G127', 'G130', 'Plus', '56 Oak Avenue', '78 Willow Lane', 12.3, 18000, 'P008'),
('T10106', 'G123', 'G128', 'Standard', '89 Pine Road', '56 Spruce Avenue', 2.1, 8000, 'P010'),
('T10107', 'G124', 'G129', 'Economy', '45 Birch Lane', '23 Cedar Road', 9.6, 13000, 'P006'),
('T10108', 'G125', 'G130', 'Plus', '67 Cedar Street', '34 Oak Lane', 17.5, 22000, 'P004'),
('T10109', 'G126', 'G131', 'Standard', '78 Willow Lane', '56 Oak Avenue', 5.9, 14000, 'P009'),
('T10110', 'G127', 'G132', 'Economy', '45 Spruce Avenue', '89 Maple Drive', 8.0, 11500, 'P001'),
('T10111', 'G123', 'G128', 'Standard', '15 Cedar Road', '30 Willow Lane', 3.7, 9000, 'P002'),
('T10112', 'G124', 'G131', 'Economy', '25 Spruce Avenue', '40 Oak Lane', 8.9, 14000, 'P003'),
('T10113', 'G125', 'G132', 'Plus', '18 Pine Avenue', '35 Birch Road', 16.2, 19000, 'P005'),
('T10114', 'G126', 'G129', 'Standard', '22 Elm Lane', '45 Cedar Street', 7.5, 11000, 'P007'),
('T10115', 'G127', 'G130', 'Economy', '30 Willow Lane', '15 Cedar Road', 5.1, 10000, 'P008'),
('T10116', 'G123', 'G129', 'Plus', '40 Oak Lane', '25 Spruce Avenue', 12.8, 17000, 'P010'),
('T10117', 'G123', 'G129', 'Standard', '32 Wall Street', '12 Abbey Road', 2.8, 8000, 'P006'),
('T10118', 'G124', 'G128', 'Economy', '67 Cedar Street', '34 Maple Drive', 9.3, 13000, 'P004'),
('T10119', 'G125', 'G130', 'Plus', '78 Willow Lane', '56 Oak Avenue', 14.5, 20000, 'P009'),
('T10120', 'G124', 'G128', 'Standard', '56 Spruce Avenue', '89 Pine Road', 6.0, 12000, 'P001');
UNLOCK TABLES;

--
-- Table CompletedTrips
--
CREATE TABLE CompletedTrips  
(
  `TripID` varchar(15) NOT NULL,
  `DriverArrivedAt` timestamp NOT NULL,
  `PickupTime` TIMESTAMP NOT NULL,
  `DropoffTime` TIMESTAMP NOT NULL,
  `Duration` int NOT NULL,
  `ActFare` float NOT NULL,
  `Tip` float NOT NULL,
  
  PRIMARY KEY(TripID),
  FOREIGN KEY (TripID) REFERENCES TripRequests(TripID) ON DELETE CASCADE
);

LOCK TABLE `CompletedTrips` WRITE;
INSERT INTO `CompletedTrips` VALUES
('T10101', '2023-01-15 08:15:00', '2023-01-15 08:30:00', '2023-01-15 09:00:00', 30, 18000, 2500),
('T10102', '2023-02-20 12:45:00', '2023-02-20 13:00:00', '2023-02-20 13:30:00', 30, 22000, 2800),
('T10103', '2023-03-25 09:30:00', '2023-03-25 09:45:00', '2023-03-25 10:15:00', 30, 15000, 2000),
('T10104', '2023-04-10 18:00:00', '2023-04-10 18:15:00', '2023-04-10 18:45:00', 30, 11000, 1500),
('T10105', '2023-05-05 14:20:00', '2023-05-05 14:35:00', '2023-05-05 15:05:00', 30, 20000, 2500),
('T10106', '2023-06-12 07:00:00', '2023-06-12 07:15:00', '2023-06-12 07:45:00', 30, 8000, 1000),
('T10107', '2023-07-18 22:50:00', '2023-07-18 23:05:00', '2023-07-18 23:35:00', 30, 13000, 1800),
('T10108', '2023-08-23 16:35:00', '2023-08-23 16:50:00', '2023-08-23 17:20:00', 30, 22000, 3000),
('T10109', '2023-09-30 11:15:00', '2023-09-30 11:30:00', '2023-09-30 12:00:00', 30, 14000, 2000),
('T10110', '2023-10-08 03:40:00', '2023-10-08 03:55:00', '2023-10-08 04:25:00', 30, 11500, 1500);
UNLOCK TABLES;

--
-- Table IncompleteTrips
--
CREATE TABLE IncompleteTrips  
(
  `TripID` varchar(15) NOT NULL,
  `BookingTime` timestamp NOT NULL, 
  `CancelTime` timestamp NOT NULL, 
  `Reason` varchar(50) NOT NULL,
  
  PRIMARY KEY(TripID),
  FOREIGN KEY (TripID) REFERENCES TripRequests(TripID) ON DELETE CASCADE
);

LOCK TABLE `IncompleteTrips` WRITE;
INSERT INTO `IncompleteTrips` VALUES
('T10111', '2023-01-15 08:30:00', '2023-01-15 08:32:00', 'Too much waiting'),
('T10112', '2023-02-20 13:00:00', '2023-02-20 13:05:00', 'Driver did not arrive'),
('T10113', '2023-03-25 09:45:00', '2023-03-25 09:50:00', 'Change my mind'),
('T10114', '2023-04-10 18:15:00', '2023-04-10 18:18:00', 'Too much traffic'),
('T10115', '2023-05-05 14:35:00', '2023-05-05 14:40:00', 'Canceled by driver'),
('T10116', '2023-06-12 07:15:00', '2023-06-12 07:20:00', 'Too much waiting'),
('T10117', '2023-07-18 23:05:00', '2023-07-18 23:10:00', 'Change my mind'),
('T10118', '2023-08-23 16:50:00', '2023-08-23 16:55:00', 'Canceled by driver'),
('T10119', '2023-09-30 11:30:00', '2023-09-30 11:35:00', 'Driver did not arrive'),
('T10120', '2023-10-08 03:55:00', '2023-10-08 04:00:00', 'Too much traffic');
UNLOCK TABLES;

-- 
-- Table Rating
--
CREATE TABLE Rating  
(
  `TripID` varchar(15) NOT NULL,
  `DriverRating` int NOT NULL,
  `CustomerRating` int NOT NULL,  
  `DriverFeedback` varchar(50) NOT NULL,
  `CustomerFeedback` varchar(50) NOT NULL,

  PRIMARY KEY(TripID),
  FOREIGN KEY (TripID) REFERENCES CompletedTrips(TripID) ON DELETE CASCADE
);

LOCK TABLE `Rating` WRITE;
INSERT INTO `Rating` VALUES
('T10101', 5, 4, 'Great Chat', 'Punctual'),
('T10102', 4, 5, 'Friendly', 'Good Driving'),
('T10103', 3, 4, 'Not Punctual', 'Average Driving'),
('T10104', 5, 3, 'Great Chat', 'Careless Driving'),
('T10105', 4, 5, 'Friendly', 'Punctual'),
('T10106', 5, 4, 'Great Chat', 'Good Driving'),
('T10107', 3, 2, 'Not Punctual', 'Careless Driving'),
('T10108', 5, 4, 'Friendly', 'Average Driving'),
('T10109', 4, 5, 'Great Chat', 'Punctual'),
('T10110', 3, 3, 'Not Punctual', 'Average Driving');
UNLOCK TABLES;

