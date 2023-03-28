DROP DATABASE IF EXISTS MUS11C;
CREATE DATABASE MUS11C;
USE MUS11C;

DROP TABLE IF EXISTS ``;
CREATE TABLE ``(
    `id` INT NOT NULL,
    ...
    PRIMARY KEY (``),
    FOREIGN KEY (``) REFERENCES ``(``) ON DELETE CASCADE ON UPDATE CASCADE
)

DROP TABLE IF EXISTS `album`;
CREATE TABLE `album`(
    `album_id` VARCHAR(8) NOT NULL,
    `album_name` VARCHAR(50) NOT NULL,
	`cover` VARCHAR(255) NOT NULL,
	`release_date` DATETIME,
    PRIMARY KEY (`album_id`)
)

DROP TABLE IF EXISTS `artist`;
CREATE TABLE `artist`(
    `artist_id` VARCHAR(8) NOT NULL,
	`artist_name` VARCHAR(50) NOT NULL,
	`artist_bio` VARCHAR(500),
    PRIMARY KEY (`artist_id`)
)

DROP TABLE IF EXISTS `album_artist`;
CREATE TABLE `album_artist`(
    `album_id` VARCHAR(8) NOT NULL,
    `artist_id` VARCHAR(8) NOT NULL,
    PRIMARY KEY (`album_id`, `artist_id`),
    FOREIGN KEY (`album_id`) REFERENCES `album`(`album_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`artist_id`) REFERENCES `artist`(`artist_id`) ON DELETE CASCADE ON UPDATE CASCADE
)

DROP TABLE IF EXISTS `genre`;
CREATE TABLE `genre`(
    `genre_id` VARCHAR(8) NOT NULL,
	`genre_name` VARCHAR(50) NOT NULL
)

DROP TABLE IF EXISTS `track`;
CREATE TABLE `track`(
    `track_id` VARCHAR(8) NOT NULL,
	`track_name` VARCHAR(50) NOT NULL,
	`time_length` INT NOT NULL,
	`lyrics` VARCHAR(1000),
	`language` VARCHAR(10),
	`source` VARCHAR(255) NOT NULL,
	`album_id` VARCHAR(8) NOT NULL, 
	`genre_id` VARCHAR(8) NOT NULL,
    PRIMARY KEY (`track_id`),
    FOREIGN KEY (`album_id`) REFERENCES `album`(`album_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`genre_id`) REFERENCES `genre`(`genre_id`) ON DELETE CASCADE ON UPDATE CASCADE
)

DROP TABLE IF EXISTS `track_artist`;
CREATE TABLE `track_artist`(
    `track_id` VARCHAR(8) NOT NULL,
	`artist_id` VARCHAR(8) NOT NULL,
	PRIMARY KEY (`track_id`, `artist_id`),
    FOREIGN KEY (`track_id`) REFERENCES `track`(`track_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`artist_id`) REFERENCES `artist`(`artist_id`) ON DELETE CASCADE ON UPDATE CASCADE
)

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
)

DROP TABLE IF EXISTS `playlist`;
CREATE TABLE `playlist`(
    `playlist_id` VARCHAR(8) NOT NULL,
	`playlist_name` VARCHAR(50) NOT NULL,
	`playlist_bio` VARCHAR(500),
	`created_date` DATETIME NOT NULL,
	`user_id` VARCHAR(8) NOT NULL,
	PRIMARY KEY (`playlist_id`),
    FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
)

DROP TABLE IF EXISTS `playlist_track`;
CREATE TABLE `playlist_track`(
    `playlist_id` VARCHAR(8) NOT NULL,
	`track_id` VARCHAR(8) NOT NULL,
	PRIMARY KEY (`playlist_id`, `track_id`),
    FOREIGN KEY (`playlist_id`) REFERENCES `playlist`(`playlist_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`track_id`) REFERENCES `track`(`track_id`) ON DELETE CASCADE ON UPDATE CASCADE
)

DROP TABLE IF EXISTS `subscription`;
CREATE TABLE `subscription`(
    `subscription_id` VARCHAR(8) NOT NULL,
	`duration` INT NOT NULL,
	`subscribe_date` DATETIME NOT NULL,
	`price` DECIMAL(5, 2) NOT NULL,
	`payment_method` VARCHAR(30) NOT NULL,
	`is_autosubscription` BOOLEAN NOT NULL，
	`user_id` VARCHAR(8) NOT NULL,
    PRIMARY KEY (`subscription_id`),
    FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
)

DROP TABLE IF EXISTS `album_comment`;
CREATE TABLE `album_comment`(
    `albcmt_id` VARCHAR(8) NOT NULL,
	`album_id` VARCHAR(8) NOT NULL,
	`user_id` VARCHAR(8) NOT NULL,
	`cmt_text` VARCHAR(1000) NOT NULL,
	`cmt_datetime` DATETIME NOT NULL,
	`like_num` INT default 0,
    PRIMARY KEY (`albcmt_id`),
    FOREIGN KEY (`album_id`) REFERENCES `album`(`album_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
)

DROP TABLE IF EXISTS `track_comment`;
CREATE TABLE `track_comment`(
    `tracmt_id` VARCHAR(8) NOT NULL,
	`track_id` VARCHAR(8) NOT NULL,
	`user_id` VARCHAR(8) NOT NULL,
	`cmt_text` VARCHAR(1000) NOT NULL,
	`cmt_datetime` DATETIME NOT NULL,
	`like_num` INT DEFAULT 0,
    PRIMARY KEY (`tracmt_id`),
    FOREIGN KEY (`track_id`) REFERENCES `track`(`track_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
)

DROP TABLE IF EXISTS `album_reply`;
CREATE TABLE `album_reply`(
    `albrpl_id` VARCHAR(8) NOT NULL,
	`reply_text` VARCHAR(1000) NOT NULL,
	`albcmt_id` VARCHAR(8) NOT NULL,
	`user_id` VARCHAR(8) NOT NULL,
	`reply_datetime` DATETIME NOT NULL,
	`like_num` INT DEFAULT 0, 
    PRIMARY KEY (`albrpl_id`),
    FOREIGN KEY (`albcmt_id`) REFERENCES `album_comment`(`albcmt_id`) ON DELETE CASCADE ON UPDATE CASCADE
	FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
)


DROP TABLE IF EXISTS `track_reply`;
CREATE TABLE `track_reply`(
    `trarpl_id` VARCHAR(8) NOT NULL,
	`tracmt_id` VARCHAR(8) NOT NULL,
	`user_id` VARCHAR(8) NOT NULL,
	`cmt_text` VARCHAR(1000) NOT NULL,
	`cmt_datetime` DATETIME NOT NULL,
	`like_num` INT DEFAULT 0,
    PRIMARY KEY (`trarpl_id`),
    FOREIGN KEY (`tracmt_id`) REFERENCES `track_comment`(`tracmt_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
)

DROP TABLE IF EXISTS `like_music`;
CREATE TABLE `like_music`(
    `user_id` VARCHAR(8) NOT NULL,
	`track_id` VARCHAR(8) NOT NULL,
	`like_datetime` DATETIME NOT NULL,
    PRIMARY KEY (`user_id`, `track_id`),
    FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`track_id`) REFERENCES `track`(`track_id`) ON DELETE CASCADE ON UPDATE CASCADE
)

DROP TABLE IF EXISTS `like_album`;
CREATE TABLE `like_album`(
    `user_id` VARCHAR(8) NOT NULL,
	`album_id` VARCHAR(8) NOT NULL,
	`like_datetime` DATETIME NOT NULL,
    PRIMARY KEY (`user_id`, `album_id`),
	FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`album_id`) REFERENCES `album`(`album_id`) ON DELETE CASCADE ON UPDATE CASCADE
)

DROP TABLE IF EXISTS `play`;
CREATE TABLE `play`(
    `play_id` VARCHAR(8) NOT NULL,
    `track_id` VARCHAR(8) NOT NULL,
	`user_id` VARCHAR(8) NOT NULL,
	`play_datetime` DATETIME NOT NULL,
    PRIMARY KEY (`play_id`),
    FOREIGN KEY (`track_id`) REFERENCES `track`(`track_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
)

-- Create view
CREATE VIEW [Brazil Customers] AS
SELECT CustomerName, ContactName
FROM Customers
WHERE Country = 'Brazil';



-- top10_most_user_played (unique(user_id) under one track)
CREATE VIEW [top10_most_user_played] AS
SELECT track.track_name as Track, COUNT(DISTINCT play.user_id) as PlayUser
FROM play, track
WHERE play.track_id = track.track_id
ORDER BY PlayUser DESC
LIMIT 10;

-- top10_most_played (play times under one track)
CREATE VIEW [top10_most_played] AS
SELECT track.track_name, DISTINCT COUNT(*) AS COUNT
FROM 


-- genre view
CREATE VIEW [Genre View] AS
SELECT *
FROM
SELECT genre_id, track_name
From track
Left join genre
ON track.genre_id = genre.genre_id


-- user_play_report
-- 还没统计 top_artist, top_track, top_genre, num_artist
CREATE VIEW [User weekly play report]
SELECT user_id, SUM(track.time_length) as top_play_time
FROM playlist
WHERE DATEDIFF(day, play_datetime, GETDATE()) = 7
LEFT JOIN track
ON playlist.track_id = track.track_id
GROUP BY user_id


-- 登记入住存储过程
CREATE PROCEDURE PROC_CheckIn @顾客姓名 nchar(10), @身份证号 nchar(20), @性别 nchar(5), @联系方式 nchar(20), @房间号 nchar(10), @入住时间 nchar(20), @操作员 nchar(10), @结果 nchar(20) OUTPUT
AS 
BEGIN
BEGIN TRANSACTION checkin
	DECLARE @cusID nchar(20)
	SELECT @cusID=customerID FROM customer WHERE @身份证号=customerID
	IF @cusID IS NULL
		INSERT INTO customer(customerID, [name], sex, tel) VALUES (@身份证号, @顾客姓名, @性别, @联系方式)
	ELSE
		BEGIN
		DECLARE @cusName nchar(10), @cusSex nchar(5)
		SELECT @cusName=[name], @cusSex=sex from customer where @cusID=customerID
		IF NOT (@性别=@cusSex AND @顾客姓名=@cusName)
			BEGIN
			SET @结果='客户基本信息冲突'
			ROLLBACK TRANSACTION checkin
			RETURN
			END
		ELSE
			UPDATE customer SET tel=@联系方式 where customerID=@身份证号
		END
	INSERT INTO checkIn(checkInTime, customerID, fgNO, roomNO) VALUES (@入住时间, @身份证号, @操作员, @房间号)
	SET @结果='成功'
	COMMIT 
END
GO


-- 预约入住存储过程
CREATE PROCEDURE PROC_CheckInWithPreserve @顾客姓名 nchar(10), @身份证号 nchar(20), @性别 nchar(5), @联系方式 nchar(20), @房间号 nchar(10), @预约号 nchar(10), @入住时间 nchar(20), @操作员 nchar(10), @结果 nchar(20) OUTPUT
AS
BEGIN
	BEGIN TRANSACTION checkinwithpreserve

	DECLARE @cusID nchar(20), @roomNO nchar(10), @result char(20)
	SELECT @cusID=customerID, @roomNO=roomNO from preserve where preserveID=@预约号
	IF @cusID IS NULL
		BEGIN
		SET @结果='无此预约信息'
		ROLLBACK TRANSACTION checkinwithpreserve
		RETURN
		END	
	IF NOT @cusID=@身份证号
		BEGIN
		SET @结果='入住人与预约人不符'
		ROLLBACK TRANSACTION checkinwithpreserve
		RETURN
		END
	IF NOT @roomNO=@房间号
		BEGIN
		SET @结果='入住房间与预约不符'
		ROLLBACK TRANSACTION checkinwithpreserve
		RETURN
		END
	EXECUTE PROC_CheckIn @顾客姓名=@顾客姓名, @身份证号=@身份证号, @性别=@性别, @联系方式=@联系方式, @房间号=@房间号, @入住时间=@入住时间, @操作员=@操作员, @结果=@result
	IF NOT @result='成功'
		BEGIN
		SET @结果=@result
		ROLLBACK TRANSACTION checkinwithpreserve
		RETURN
		END
	UPDATE checkIn SET preserveID=@预约号 where customerID=@身份证号 AND roomNO=@房间号
	SET @结果=@result
	COMMIT
	RETURN
END
GO
