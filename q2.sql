 DELIMITER //

 CREATE PROCEDURE GetWatchHistoryBySubscriber(IN sub_id INT)
 BEGIN
 -- Joining both Shows and Watch history tables to get show details and watch time in the same table
 SELECT s.ShowID, s.Title, s.Genre, s.ReleaseYear, w.WatchTime
 FROM Shows s INNER JOIN WatchHistory w 
 WHERE s.ShowID = w.ShowID AND SubscriberID = sub_id;
 END //

 DELIMITER ;

 -- Call the procedure
 CALL GetWatchHistoryBySubscriber(1);