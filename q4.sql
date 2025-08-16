DELIMITER //

 CREATE PROCEDURE SendWatchTimeReport()
 BEGIN
 
 DECLARE done INT DEFAULT FALSE;
 DECLARE sub_id INT;

 DECLARE cur CURSOR FOR 
     SELECT SubscriberID FROM Subscribers;

 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
 OPEN cur;
 
 read_loop: LOOP
 FETCH cur INTO sub_id;
 IF done THEN
 LEAVE read_loop;
 END IF;
 
    -- Checking if the subscriber has watch time or not by checking if the total watch time is greater than 0
    IF (SELECT sum(WatchTime) FROM WatchHistory WHERE SubscriberID = sub_id) > 0 THEN
       CALL GetWatchHistoryBySubscriber(sub_id);
    END IF;

 END LOOP;
 
 CLOSE cur;
 END //

 DELIMITER ;

 -- Call the procedure
 CALL SendWatchTimeReport();