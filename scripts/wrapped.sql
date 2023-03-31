-- WRAPPED

-- total_play_time, top_artist, top_track, top_genre, num_artist
SET @userid = 'USR0005';
-- SET @opt = 0;
SET @requestYear = '2023';
SET @requestMonth = '3';

-- DELIMITER $$
-- CREATE FUNCTION time_pickup (opt INT)
-- RETURNS VARCHAR(1000)
-- READS SQL DATA
-- DETERMINISTIC
-- BEGIN
-- 	DECLARE result VARCHAR(1000);
--     SET result = CASE opt
-- 		WHEN 0 THEN CONCAT("DATEDIFF(CURDATE(), play_datetime) <= 7")
-- 		WHEN 1 THEN CONCAT("YEAR(play_datetime) = ", @requestYear, "AND MONTH(play_datetime) = ", @requestMonth)
-- 		WHEN 2 THEN CONCAT("YEAR(play_datetime) = ", @requestYear)
-- 	END;
--     RETURN result;
-- END$$
-- DELIMITER ;





-- Weekly report
-- -- get user name
SELECT user_name as `User Name`, `Total Play Time`, artist_name as `Top Artist`, track_name as `Top Track`, genre_name as `Top Genre`
FROM (
    SELECT user_id, user_name
    FROM `user`
    WHERE user_id = @userid
    ) username

LEFT JOIN (
    -- -- total play time
    SELECT play.user_id, sum(time_length) AS `Total Play Time`
    FROM play
    LEFT JOIN track
    ON play.track_id = track.track_id
    WHERE DATEDIFF(CURDATE(), play_datetime) <= 7 AND play.user_id = @userid
    GROUP BY play.user_id
    ) total_play_time

ON username.user_id = total_play_time.user_id

LEFT JOIN (
    -- -- top artist
    SELECT @userid as user_id, artist_name
    FROM (
        SELECT artist_id, COUNT(*) AS played_cnt
        FROM play
        LEFT JOIN track_artist
        ON play.track_id = track_artist.track_id
        WHERE DATEDIFF(CURDATE(), play_datetime) <= 7 AND play.user_id = @userid
        GROUP BY artist_id
        ORDER BY played_cnt DESC
        LIMIT 1
    ) a
    LEFT JOIN artist b
    ON a.artist_id = b.artist_id ) top_artist

ON username.user_id = top_artist.user_id

LEFT JOIN (
    -- -- top track
    SELECT @userid as user_id, track_name
    FROM (
        SELECT track_id, COUNT(*) as played_cnt
        FROM play
        WHERE DATEDIFF(CURDATE(), play_datetime) <= 7 AND play.user_id = @userid
        GROUP BY track_id
        ORDER BY played_cnt DESC
        LIMIT 1
        ) a
    LEFT JOIN track b
    ON a.track_id = b.track_id) top_track

ON username.user_id = top_track.user_id

LEFT JOIN (
    -- -- top genre
    SELECT @userid as user_id, genre_name
    FROM ( 
        SELECT genre_id, COUNT(*) as genre_cnt
        FROM play
        LEFT JOIN track
        on play.track_id = track.track_id
        WHERE DATEDIFF(CURDATE(), play_datetime) <= 7 AND play.user_id = @userid
        GROUP BY genre_id
        ORDER BY genre_cnt DESC
        LIMIT 1
    ) a
    LEFT JOIN genre b
    ON a.genre_id = b.genre_id) top_genre

ON username.user_id = top_genre.user_id;





-- Monthly report
SELECT user_name as `User Name`, `Total Play Time`, artist_name as `Top Artist`, track_name as `Top Track`, genre_name as `Top Genre`
FROM (
    SELECT user_id, user_name
    FROM `user`
    WHERE user_id = @userid
    ) username

LEFT JOIN (
    -- -- total play time
    SELECT play.user_id, sum(time_length) AS `Total Play Time`
    FROM play
    LEFT JOIN track
    ON play.track_id = track.track_id
    WHERE YEAR(play_datetime) = @requestYear AND MONTH(play_datetime) = @requestMonth AND play.user_id = @userid
    GROUP BY play.user_id
    ) total_play_time

ON username.user_id = total_play_time.user_id

LEFT JOIN (
    -- -- top artist
    SELECT @userid as user_id, artist_name
    FROM (
        SELECT artist_id, COUNT(*) AS played_cnt
        FROM play
        LEFT JOIN track_artist
        ON play.track_id = track_artist.track_id
        WHERE YEAR(play_datetime) = @requestYear AND MONTH(play_datetime) = @requestMonth AND play.user_id = @userid
        GROUP BY artist_id
        ORDER BY played_cnt DESC
        LIMIT 1
    ) a
    LEFT JOIN artist b
    ON a.artist_id = b.artist_id ) top_artist

ON username.user_id = top_artist.user_id

LEFT JOIN (
    -- -- top track
    SELECT @userid as user_id, track_name
    FROM (
        SELECT track_id, COUNT(*) as played_cnt
        FROM play
        WHERE YEAR(play_datetime) = @requestYear AND MONTH(play_datetime) = @requestMonth AND play.user_id = @userid
        GROUP BY track_id
        ORDER BY played_cnt DESC
        LIMIT 1
        ) a
    LEFT JOIN track b
    ON a.track_id = b.track_id) top_track

ON username.user_id = top_track.user_id

LEFT JOIN (
    -- -- top genre
    SELECT @userid as user_id, genre_name
    FROM ( 
        SELECT genre_id, COUNT(*) as genre_cnt
        FROM play
        LEFT JOIN track
        on play.track_id = track.track_id
        WHERE YEAR(play_datetime) = @requestYear AND MONTH(play_datetime) = @requestMonth AND play.user_id = @userid
        GROUP BY genre_id
        ORDER BY genre_cnt DESC
        LIMIT 1
    ) a
    LEFT JOIN genre b
    ON a.genre_id = b.genre_id) top_genre

ON username.user_id = top_genre.user_id;




-- Yearly report
SELECT user_name as `User Name`, `Total Play Time`, artist_name as `Top Artist`, track_name as `Top Track`, genre_name as `Top Genre`
FROM (
    SELECT user_id, user_name
    FROM `user`
    WHERE user_id = @userid
    ) username

LEFT JOIN (
    -- -- total play time
    SELECT play.user_id, sum(time_length) AS `Total Play Time`
    FROM play
    LEFT JOIN track
    ON play.track_id = track.track_id
    WHERE YEAR(play_datetime) = @requestYear AND play.user_id = @userid
    GROUP BY play.user_id
    ) total_play_time

ON username.user_id = total_play_time.user_id

LEFT JOIN (
    -- -- top artist
    SELECT @userid as user_id, artist_name
    FROM (
        SELECT artist_id, COUNT(*) AS played_cnt
        FROM play
        LEFT JOIN track_artist
        ON play.track_id = track_artist.track_id
        WHERE YEAR(play_datetime) = @requestYear AND play.user_id = @userid
        GROUP BY artist_id
        ORDER BY played_cnt DESC
        LIMIT 1
    ) a
    LEFT JOIN artist b
    ON a.artist_id = b.artist_id ) top_artist

ON username.user_id = top_artist.user_id

LEFT JOIN (
    -- -- top track
    SELECT @userid as user_id, track_name
    FROM (
        SELECT track_id, COUNT(*) as played_cnt
        FROM play
        WHERE YEAR(play_datetime) = @requestYear AND play.user_id = @userid
        GROUP BY track_id
        ORDER BY played_cnt DESC
        LIMIT 1
        ) a
    LEFT JOIN track b
    ON a.track_id = b.track_id) top_track

ON username.user_id = top_track.user_id

LEFT JOIN (
    -- -- top genre
    SELECT @userid as user_id, genre_name
    FROM ( 
        SELECT genre_id, COUNT(*) as genre_cnt
        FROM play
        LEFT JOIN track
        on play.track_id = track.track_id
        WHERE YEAR(play_datetime) = @requestYear AND play.user_id = @userid
        GROUP BY genre_id
        ORDER BY genre_cnt DESC
        LIMIT 1
    ) a
    LEFT JOIN genre b
    ON a.genre_id = b.genre_id) top_genre

ON username.user_id = top_genre.user_id;
