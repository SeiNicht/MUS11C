DROP DATABASE IF EXISTS MUS11C;
CREATE DATABASE MUS11C;
USE MUS11C;


-- Create tables
DROP TABLE IF EXISTS `album`;
CREATE TABLE `album`(
    `album_id` VARCHAR(8) NOT NULL,
    `album_name` VARCHAR(50) NOT NULL,
	`cover` VARCHAR(255) NOT NULL,
	`release_date` DATETIME,
    PRIMARY KEY (`album_id`)
);

DROP TABLE IF EXISTS `artist`;
CREATE TABLE `artist`(
    `artist_id` VARCHAR(8) NOT NULL,
	`artist_name` VARCHAR(50) NOT NULL,
	`artist_bio` TEXT,
    PRIMARY KEY (`artist_id`)
);

DROP TABLE IF EXISTS `album_artist`;
CREATE TABLE `album_artist`(
    `album_id` VARCHAR(8) NOT NULL,
    `artist_id` VARCHAR(8) NOT NULL,
    PRIMARY KEY (`album_id`, `artist_id`),
    FOREIGN KEY (`album_id`) REFERENCES `album`(`album_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`artist_id`) REFERENCES `artist`(`artist_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `genre`;
CREATE TABLE `genre`(
    `genre_id` VARCHAR(8) NOT NULL,
	`genre_name` VARCHAR(50) NOT NULL,
	PRIMARY KEY (`genre_id`)
);

DROP TABLE IF EXISTS `language`;
CREATE TABLE `language`(
    `language_id` VARCHAR(8) NOT NULL,
	`language_name` VARCHAR(50) NOT NULL,
	PRIMARY KEY (`language_id`)
);

DROP TABLE IF EXISTS `track`;
CREATE TABLE `track`(
    `track_id` VARCHAR(8) NOT NULL,
	`track_name` VARCHAR(50) NOT NULL,
	`time_length` INT NOT NULL,
	`lyrics` TEXT,
	`language_id` VARCHAR(8),
	`source` VARCHAR(255) NOT NULL,
	`album_id` VARCHAR(8) NOT NULL, 
	`genre_id` VARCHAR(8) NOT NULL,
    PRIMARY KEY (`track_id`),
    FOREIGN KEY (`album_id`) REFERENCES `album`(`album_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `language`(`language_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`genre_id`) REFERENCES `genre`(`genre_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `track_artist`;
CREATE TABLE `track_artist`(
    `track_id` VARCHAR(8) NOT NULL,
	`artist_id` VARCHAR(8) NOT NULL,
	PRIMARY KEY (`track_id`, `artist_id`),
    FOREIGN KEY (`track_id`) REFERENCES `track`(`track_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`artist_id`) REFERENCES `artist`(`artist_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`(
    `user_id` VARCHAR(8) NOT NULL,
	`user_name` VARCHAR(50) NOT NULL,
	`email` VARCHAR(50) NOT NULL UNIQUE,
	`password` VARCHAR(20) NOT NULL,
	`avatar` VARCHAR(255) NOT NULL,
	`register_datatime` DATETIME NOT NULL,
	`last_login_datetime` DATETIME NOT NULL,
	PRIMARY KEY (`user_id`)
);

DROP TABLE IF EXISTS `playlist`;
CREATE TABLE `playlist`(
    `playlist_id` VARCHAR(8) NOT NULL,
	`playlist_name` VARCHAR(50) NOT NULL,
	`playlist_bio` TEXT,
	`created_date` DATETIME NOT NULL,
	`user_id` VARCHAR(8) NOT NULL,
	PRIMARY KEY (`playlist_id`),
    FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `playlist_track`;
CREATE TABLE `playlist_track`(
    `playlist_id` VARCHAR(8) NOT NULL,
	`track_id` VARCHAR(8) NOT NULL,
	PRIMARY KEY (`playlist_id`, `track_id`),
    FOREIGN KEY (`playlist_id`) REFERENCES `playlist`(`playlist_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`track_id`) REFERENCES `track`(`track_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `subscription`;
CREATE TABLE `subscription`(
    `subscription_id` VARCHAR(8) NOT NULL,
	`duration` INT NOT NULL,
	`subscribe_date` DATETIME NOT NULL,
	`price` DECIMAL(5, 2) NOT NULL,
	`payment_method` VARCHAR(30) NOT NULL,
	`is_autosubscription` BOOLEAN NOT NULL,
	`user_id` VARCHAR(8) NOT NULL,
    PRIMARY KEY (`subscription_id`),
    FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `album_comment`;
CREATE TABLE `album_comment`(
    `albcmt_id` VARCHAR(8) NOT NULL,
	`album_id` VARCHAR(8) NOT NULL,
	`user_id` VARCHAR(8) NOT NULL,
	`cmt_text` TEXT NOT NULL,
	`cmt_datetime` DATETIME NOT NULL,
	`like_num` INT default 0,
    PRIMARY KEY (`albcmt_id`),
    FOREIGN KEY (`album_id`) REFERENCES `album`(`album_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `track_comment`;
CREATE TABLE `track_comment`(
    `tracmt_id` VARCHAR(8) NOT NULL,
	`track_id` VARCHAR(8) NOT NULL,
	`user_id` VARCHAR(8) NOT NULL,
	`cmt_text` TEXT NOT NULL,
	`cmt_datetime` DATETIME NOT NULL,
	`like_num` INT DEFAULT 0,
    PRIMARY KEY (`tracmt_id`),
    FOREIGN KEY (`track_id`) REFERENCES `track`(`track_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `album_reply`;
CREATE TABLE `album_reply`(
    `albrpl_id` VARCHAR(8) NOT NULL,
	`reply_text` TEXT NOT NULL,
	`albcmt_id` VARCHAR(8) NOT NULL,
	`user_id` VARCHAR(8) NOT NULL,
	`reply_datetime` DATETIME NOT NULL,
	`like_num` INT DEFAULT 0, 
    PRIMARY KEY (`albrpl_id`),
    FOREIGN KEY (`albcmt_id`) REFERENCES `album_comment`(`albcmt_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `track_reply`;
CREATE TABLE `track_reply`(
    `trarpl_id` VARCHAR(8) NOT NULL,
	`reply_text` TEXT NOT NULL,
	`tracmt_id` VARCHAR(8) NOT NULL,
	`user_id` VARCHAR(8) NOT NULL,
	`reply_datetime` DATETIME NOT NULL,
	`like_num` INT DEFAULT 0,
    PRIMARY KEY (`trarpl_id`),
    FOREIGN KEY (`tracmt_id`) REFERENCES `track_comment`(`tracmt_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `like_music`;
CREATE TABLE `like_music`(
    `user_id` VARCHAR(8) NOT NULL,
	`track_id` VARCHAR(8) NOT NULL,
	`like_datetime` DATETIME NOT NULL,
    PRIMARY KEY (`user_id`, `track_id`),
    FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`track_id`) REFERENCES `track`(`track_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `like_album`;
CREATE TABLE `like_album`(
    `user_id` VARCHAR(8) NOT NULL,
	`album_id` VARCHAR(8) NOT NULL,
	`like_datetime` DATETIME NOT NULL,
    PRIMARY KEY (`user_id`, `album_id`),
	FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`album_id`) REFERENCES `album`(`album_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `play`;
CREATE TABLE `play`(
    `play_id` VARCHAR(8) NOT NULL,
    `track_id` VARCHAR(8) NOT NULL,
	`user_id` VARCHAR(8) NOT NULL,
	`play_datetime` DATETIME NOT NULL,
    PRIMARY KEY (`play_id`),
    FOREIGN KEY (`track_id`) REFERENCES `track`(`track_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Create views
-- Tracks most popular (most users have played)
CREATE VIEW `top10_most_user_played` AS
SELECT play.track_id AS `Track ID`, track.track_name AS `Track`, COUNT(DISTINCT play.user_id) AS `User Count`
FROM play
LEFT JOIN track
ON play.track_id = track.track_id
GROUP BY play.track_id
ORDER BY `User Count` DESC
LIMIT 10;

-- Tracks that played most times
CREATE VIEW `top10_most_played` AS
SELECT play.track_id AS `Track ID`, track.track_name AS `Track`, COUNT(play.play_id) AS `User Count`
FROM play
LEFT JOIN track
ON track.track_id = play.track_id
GROUP BY play.track_id
ORDER BY `User Count` DESC
LIMIT 10;

-- Tracks grouped by genre
CREATE VIEW `genre_view` AS
SELECT *
FROM (
SELECT track.genre_id AS `Genre ID`, genre.genre_name AS `Genre`, track_name AS `Track`
From track
Left join genre
ON track.genre_id = genre.genre_id) as gr
ORDER BY `Genre ID`;


-- Create stored procedure
-- User registration procedure
DELIMITER $$
CREATE PROCEDURE `register_user`(
    IN p_UserName VARCHAR(50),
    IN p_Email VARCHAR(50),
    IN p_Password VARCHAR(20),
    IN p_Avatar VARCHAR(255)
)
BEGIN
    DECLARE v_UserId VARCHAR(8);
    DECLARE v_EmailCnt INT;
	START TRANSACTION;
    -- Check if email already exists
    SELECT COUNT(*) INTO v_EmailCnt FROM `user` WHERE `email` = p_Email;
    IF v_EmailCnt > 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email already registered';
        ROLLBACK;
    END IF;
    
    -- Generate user ID
    SELECT IFNULL(MAX(RIGHT(user_id, 4)), 0) INTO @max_id FROM user;
    SET v_UserId = CONCAT('USR', LPAD(@max_id + 1, 4, '0'));
    
    -- Insert user data into the database
    INSERT INTO `user` (`user_id`, `user_name`, `email`, `password`, `avatar`, `register_datatime`, `last_login_datetime`)
    VALUES (v_UserId, p_UserName, p_Email, p_Password, p_Avatar, NOW(), NOW());
    
    -- Commit the transaction
    COMMIT;
END $$
DELIMITER ;
