-- Calculate Customer Spending
DELIMITER $$

CREATE PROCEDURE Calculate_Customer_Spending(IN customerID VARCHAR(15))
BEGIN
    -- Declare variable for total spending
    DECLARE totalSpending DECIMAL(10,2);

    -- Initialize totalSpending
    SET totalSpending = 0;

    -- Calculate the total spending
    SELECT SUM(CT.ActFare) INTO totalSpending
    FROM CompletedTrips CT
    JOIN TripRequests TR ON CT.TripID = TR.TripID
    WHERE TR.CID = customerID;

    -- Check if totalSpending is NULL (which means there were no completed trips)
    IF totalSpending IS NULL THEN
        SET totalSpending = 0;
    END IF;

    -- Output the result
    SELECT customerID AS 'Customer ID', totalSpending AS 'Total Spending';
END$$

DELIMITER ;


-- Calculate Driver's Income
DELIMITER $$

CREATE PROCEDURE Calculate_Driver_Income(IN driverID VARCHAR(15))
BEGIN
    -- Declare variable for total income
    DECLARE totalIncome DECIMAL(10,2);

    -- Initialize totalIncome
    SET totalIncome = 0;

    -- Calculate the total income
    SELECT SUM(ActFare) INTO totalIncome
    FROM CompletedTrips CT
    JOIN TripRequests TR ON CT.TripID = TR.TripID
    WHERE TR.DID = driverID;

    -- Check if totalIncome is NULL (which means there were no completed trips)
    IF totalIncome IS NULL THEN
        SET totalIncome = 0;
    END IF;

    -- Output the result
    SELECT driverID AS 'Driver ID', totalIncome AS 'Total Income';
END$$

DELIMITER ;


-- Calculate Fare
DELIMITER $$

CREATE PROCEDURE Calculate_Fare(
    IN Base_fare DECIMAL(10,2), 
    IN Service_Tax DECIMAL(10,2), 
    IN Cost_per_mile DECIMAL(10,2), 
    IN Cost_per_min DECIMAL(10,2)
)
BEGIN
    -- Declare variables
    DECLARE done INT DEFAULT FALSE;
    DECLARE tripId VARCHAR(15);
    DECLARE duration INT;
    DECLARE distance FLOAT;
    DECLARE totalFare DECIMAL(10,2);

    -- Declare the cursor
    DECLARE Trip_total_fare CURSOR FOR 
        SELECT 
            CT.TripID, 
            CT.Duration, 
            TR.Distance
        FROM 
            CompletedTrips CT
        JOIN 
            TripRequests TR ON TR.TripID = CT.TripID;

    -- Declare continue handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN Trip_total_fare;

    -- Loop to fetch data from cursor
    read_loop: LOOP
        FETCH Trip_total_fare INTO tripId, duration, distance;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Calculate the total fare
        SET totalFare = Base_fare + Service_Tax + (Cost_per_mile * distance) + (Cost_per_min * duration);

        -- Output the result (Change this based on how you want to handle the output)
        SELECT totalFare AS 'Total Fare', tripId AS 'Trip ID';
    END LOOP;

    -- Close the cursor
    CLOSE Trip_total_fare;
END$$

DELIMITER ;


-- Average Rating
DELIMITER $$

CREATE PROCEDURE Average_Ratings()
BEGIN
    -- Declare variables
    DECLARE avgRating DECIMAL(5,2);
    DECLARE driverId VARCHAR(15);
    DECLARE done INT DEFAULT FALSE;

    -- Declare the cursor
    DECLARE DrivRating CURSOR FOR 
        SELECT AVG(R.DriverRating) as AvgRating, T.DID 
        FROM TripRequests T 
        JOIN Rating R ON T.TripID = R.TripID 
        GROUP BY T.DID;

    -- Declare continue handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Temporary table to store results
    CREATE TEMPORARY TABLE IF NOT EXISTS TempResults (
        AvgRating DECIMAL(5,2),
        DriverID VARCHAR(15)
    );

    -- Open the cursor
    OPEN DrivRating;

    -- Loop to fetch data from cursor
    read_loop: LOOP
        FETCH DrivRating INTO avgRating, driverId;
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- Insert the result into the temporary table
        INSERT INTO TempResults (AvgRating, DriverID) VALUES (avgRating, driverId);
    END LOOP;

    -- Close the cursor
    CLOSE DrivRating;

    -- Select all results from the temporary table
    SELECT * FROM TempResults;

    -- Drop the temporary table
    DROP TEMPORARY TABLE IF EXISTS TempResults;
END$$

DELIMITER ;