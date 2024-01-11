-- Retrieves the phone number of the customer for a specific trip with ID 'T10101'
SELECT GrabUser.Phone
FROM TripRequests
JOIN GrabUser ON TripRequests.CID = GrabUser.GrabID
WHERE TripRequests.TripID = 'T10101';