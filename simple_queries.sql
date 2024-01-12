-- 1. Retrieves the phone number of the customer for a specific trip with ID 'T10101'
SELECT GrabUser.Phone
FROM TripRequests
JOIN GrabUser ON TripRequests.CID = GrabUser.GrabID
WHERE TripRequests.TripID = 'T10101';


-- 2. Complete the trip request upon customer’s arrival destination
INSERT INTO CompletedTrips (TripID, DriverArrivedAt, PickupTime, DropoffTime, Duration, ActFare, Tip)
VALUES ('T10101', '2023-01-15 08:15:00', '2023-01-15 08:30:00', '2023-01-15 09:00:00', 30, 18000, 2500);


-- 3. Driver cancel a trip request
INSERT INTO IncompleteTrips (TripID, BookingTime, CancelTime, Reason)
VALUES ('T10101', '2023-01-15 08:00:00', '2023-01-15 08:10:00', 'Customer No Show');


-- 4. Counts the number of trips completed by the driver with ID 'G128'
SELECT COUNT(*) AS NumberOfTripsCompleted
FROM CompletedTrips
JOIN TripRequests ON CompletedTrips.TripID = TripRequests.TripID
WHERE TripRequests.DID = 'G128';


-- 5. Calculates the total income for the driver with ID 'G128' from completed trips
SELECT SUM(ActFare + Tip) AS TotalIncome
FROM CompletedTrips
JOIN TripRequests ON CompletedTrips.TripID = TripRequests.TripID
WHERE TripRequests.DID = 'G128';


-- 6. Inserts a new trip request into the database for the customer with ID 'G123'
INSERT INTO TripRequests(TripID, CID, DID, TripType, PickupLoc, DropoffLoc, Distance, EstFare, PayID)
VALUES ('T10121', 'G123', 'G128', 'Economy', '123 Start Street', '456 End Street', 10.5, 13000, 'P001');


-- 7. Customer cancel a trip request
INSERT INTO IncompleteTrips (TripID, BookingTime, CancelTime, Reason)
VALUES ('T10101', '2023-01-15 08:00:00', '2023-01-15 08:10:00', 'Customer No Show');


-- 8. Calculates the average rating of all trips conducted by the driver of the trip with ID 'T10101'
SELECT AVG(DriverRating) AS AverageDriverRating
FROM Rating
JOIN CompletedTrips ON Rating.TripID = CompletedTrips.TripID
JOIN TripRequests ON CompletedTrips.TripID = TripRequests.TripID
WHERE TripRequests.DID = (SELECT DID FROM TripRequests WHERE TripID = 'T10101');


-- 9. Retrieves the estimated fare for the trip with ID 'T10101'
SELECT EstFare
FROM TripRequests
WHERE TripID = 'T10101';


-- 10. Retrieves the list of drop-off locations for trips taken by the customer with ID 'G123'
SELECT DropoffLoc
FROM TripRequests
WHERE CID = 'G123';


-- 11. Retrieves the condition of vehicles used by the driver with ID 'G128'
SELECT Vehicle.Condition
FROM Vehicle
JOIN Driver ON Vehicle.DID = Driver.DID
WHERE Driver.DID = 'G128';


-- 12. Retrieves all customer feedback for the driver with ID 'G128'
SELECT CustomerFeedback
FROM Rating
JOIN CompletedTrips ON Rating.TripID = CompletedTrips.TripID
JOIN TripRequests ON CompletedTrips.TripID = TripRequests.TripID
WHERE TripRequests.DID = 'G128';


-- 13. Calculates the average actual fare for all completed trips, reflecting the average customer spending
SELECT AVG(ActFare) AS AverageCustomerSpending
FROM CompletedTrips;
