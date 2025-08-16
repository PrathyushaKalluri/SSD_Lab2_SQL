Github link:
https://github.com/PrathyushaKalluri/SSD_Lab2_SQL.git

STEP 1 --------
Before running the queries of the questions, we need to create 

    CREATE DATEBASE Netflix and CREATE TABLES --------

    CREATE DATABASE IF NOT EXISTS Netflix; 
    USE Netflix;

    -- Create Tables
    CREATE TABLE Shows (
    ShowID INT PRIMARY KEY,
    Title VARCHAR(100),
    Genre VARCHAR(50),
    ReleaseYear INT
    );
    CREATE TABLE Subscribers (
    SubscriberID INT PRIMARY KEY,
    SubscriberName VARCHAR(100),
    SubscriptionDate DATE
    );
    CREATE TABLE WatchHistory (
    HistoryID INT PRIMARY KEY,
    ShowID INT,
    SubscriberID INT,
    WatchTime INT, -- Duration in minutes
    FOREIGN KEY (ShowID) REFERENCES Shows(ShowID),
    FOREIGN KEY (SubscriberID) REFERENCES
    Subscribers(SubscriberID)
    );


    INSERT INTO TABLES ----------

    USE Netflix;

    -- Insert Sample Data
    INSERT INTO Shows (ShowID, Title, Genre, ReleaseYear) VALUES
    (1, 'Stranger Things', 'Sci-Fi', 2016),
    (2, 'The Crown', 'Drama', 2016),
    (3, 'The Witcher', 'Fantasy', 2019);
    INSERT INTO Subscribers (SubscriberID, SubscriberName,
    SubscriptionDate) VALUES
    (1, 'Emily Clark', '2023-01-10'),
    (2, 'Chris Adams', '2023-02-15'),
    (3, 'Jordan Smith', '2023-03-05');
    INSERT INTO WatchHistory (HistoryID, SubscriberID, ShowID,
    WatchTime) VALUES
    (1, 1, 1, 100),
    (2, 1, 2, 10),
    (3, 2, 1, 20),
    (4, 2, 2, 40),
    (5, 2, 3, 10),
    (6, 3, 2, 10),
    (7, 3, 1, 10);

    SHOW TABLES;

STEP 2 ---------
For the first question, 
    the SELECT query returns different sets separately.
    Input: No input needed
    Steps to execute: CALL ListAllSubscribers();
    Output: We will get the subscribers names as separate tables

STEP 3 ---------
For the second question, 
    we can call the stored procedure by passing the subscriber ID inserted into the table
    Input: Subscriber ID in the table
    Steps to execute: CALL GetWatchHistoryBySubscriber(1);
                      CALL GetWatchHistoryBySubscriber(2);
                      CALL GetWatchHistoryBySubscriber(3);
    Output: We will get the ShowID, Title, Genre, ReleaseYear, WatchTime of the shows seen by the subscriber

STEP 4 ---------
For the thrid question,
    If the table is empty then, we are inserting a new record with new ID 1 and
    if the table is not empty then, we are inserting a new record after the last record using maximum ID
    The subscription date is the date on which the record is added which is current date
    If the subscriber name already exists then, showing a message that the name already exists
    Input: New subscriber name
    Steps to execute: CALL AddSubscriberIfNotExists('Rohit Sharma');
    Output: A new record will be inserted
    Verification:
    Check whether the record has been added by running this query,
        SELECT * FROM Subscribers WHERE SubscriberName = 'Rohit Sharma';

STEP 5 -------
For the fourth question,
    We are checking if a subscriber has total watch time and then calling the GetWatchHistoryBySubscriber(sub_id) stored procedure internally
    Assumption: 
    The schema allows the duplicate values to insert for the same show and same subscriber but different watch times including 0
    So, when a subscriber has a show with both watch time 0 and watch time 100 it will be shown, because there is no constraint to handle duplicates in the schema.
    So, I am checking only the total watch time of a subscriber but not the individual watch time per show
    Input: No input needed
    Steps to execute: Make sure that GetWatchHistoryBySubscriber(sub_id) stored procedure is defined
                      CALL SendWatchTimeReport();
    Output: We will get the watch history of each subscriber as separate tables
    Verification:
    Insert a new record with watch time 0,
        INSERT INTO WatchHistory (HistoryID, SubscriberID, ShowID, WatchTime) VALUES (8, 4, 3, 0);
    Run the stored procedure
    Check that the subscriber with 0 watch time is not shown

STEP 6 ------
For the fifth question,
    We are looping through the whole Subscribers table and then calling the GetWatchHistoryBySubscriber(sub_id) stored procedure internally
    Input: No input needed
    Steps to execute: CALL SendWatchTimeReportsOfSubscribers();
    Output: We will get the watch time reports of all the subscribers as separate tables

