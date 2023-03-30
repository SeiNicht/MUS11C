-- User Feature Support
-- login
UPDATE `user`
SET `last_login_datetime` = NOW()
WHERE `user_id` = 'USR0001';

-- update user info (name, email, password) 
UPDATE `user`
SET `user_name` = 'John Hopkins', `email` = 'example@test.com', `password`='12345678'
WHERE user_id = 'USR0001';

-- user profile
SELECT user_id, user_name, email, avatar, register_datetime, last_login_datetime
FROM `user`
WHERE `user_id` = 'USR0001';

-- edit playlist (add/delete track, rename, update bio)
UPDATE `playlist`
SET `playlist_name` = 'homework unique', `playlist_bio` = 'Beautiful music for horrible homework!'
WHERE `playlist_id` = 'PL0001';

-- edit like_music(default) playlist
DELETE FROM like_music 
WHERE user_id = 'USR0001' AND track_id = 'TR0001';

-- edit like_album(default) list
DELETE FROM like_album 
WHERE user_id = 'USR0001' AND album_id = 'ALB0001';

-- edit subscription
UPDATE `subscription`
SET `is_autosubscription` = False
WHERE `subscription_id` = 'SUBS0001';



-- SEARCH
-- Search track by name
SELECT *
FROM track
WHERE track_name LIKE '%Bohemian%';

-- Search track by lyrics
SELECT *
FROM track
WHERE lyrics LIKE '%is this the real life%';

-- Search track by artist
SELECT *
FROM(
    SELECt track_id
    FROM track_artist
    LEFT JOIN artist
    on track_artist.artist_id = artist.artist_id
    Where artist_name LIKE '%Beatles%') a
LEFT JOIN track b
ON a.track_id = b.track_id;

-- Search album by name
SELECT *
FROM album
WHERE album_name LIKE '%Dark Side%';

-- Search album by artist
SELECT *
FROM(
    SELECt album_id
    FROM album_artist
    LEFT JOIN artist
    on album_artist.artist_id = artist.artist_id
    Where artist_name LIKE '%Beatles%') a
LEFT JOIN album b
ON a.album_id = b.album_id;


-- DISCOVER
-- Discover music classified by genre
SELECT *
FROM genre_view
ORDER BY RAND()
LIMIT 10;

-- Discover music classified by language
SELECT *
FROM language_view
WHERE `Language ID` = 'en'
ORDER BY RAND()
LIMIT 10;

-- Discover music - played by the most people
SELECT *
FROM most_user_played
LIMIT 10;

-- Discover music - most played
SELECT *
FROM most_played
LIMIT 10;

