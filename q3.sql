DELIMITER //

 CREATE PROCEDURE AddSubscriberIfNotExists(IN subName VARCHAR(100))
 BEGIN
 DECLARE newID INT;
 IF NOT EXISTS (SELECT * FROM Subscribers WHERE SubscriberName = subName) THEN
	 -- if the table is empty then default value is 0 
        -- else take the maximum subscriber ID and increment by 1
	 SELECT IFNULL(MAX(SubscriberID), 0) + 1 INTO newID FROM Subscribers;
	 -- insert the newID, name given as parameter and current date as a new record
	 INSERT IGNORE INTO Subscribers (SubscriberID, SubscriberName, SubscriptionDate)
	 VALUES (newID, subName, CURDATE());
 ELSE
	-- If subscriber already exists, you can do something else
	SELECT CONCAT('Subscriber ', subName, ' already exists.') AS message;
 END IF;
 
 END //

 DELIMITER ;

 -- Call the procedure
 CALL AddSubscriberIfNotExists('Rohit Sharma');