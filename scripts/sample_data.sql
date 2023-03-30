USE MUS11C;


-- Inserting data into the album table
INSERT INTO `album` (`album_id`, `album_name`, `cover`, `release_date`)
VALUES
('ALB0001', 'Thriller', 'https://upload.wikimedia.org/wikipedia/en/5/55/Michael_Jackson_-_Thriller.png', '1982-11-30'),
('ALB0002', 'The Dark Side of the Moon', 'https://upload.wikimedia.org/wikipedia/en/3/3b/Dark_Side_of_the_Moon.png', '1973-03-01'),
('ALB0003', 'Abbey Road', 'https://upload.wikimedia.org/wikipedia/en/4/42/Beatles_-_Abbey_Road.jpg', '1969-09-26'),
('ALB0004', '21', 'https://upload.wikimedia.org/wikipedia/en/e/e0/Adele_-_21.png', '2011-01-19'),
('ALB0005', 'Back in Black', 'https://upload.wikimedia.org/wikipedia/en/4/4c/ACDC_Back_in_Black.png', '1980-07-25');

-- Inserting data into the artist table
INSERT INTO `artist` (`artist_id`, `artist_name`, `artist_bio`)
VALUES
('ART0001', 'Michael Jackson', 'American singer, songwriter, and dancer'),
('ART0002', 'Pink Floyd', 'English rock band'),
('ART0003', 'The Beatles', 'English rock band'),
('ART0004', 'Ed Sheeran', 'English singer-songwriter'),
('ART0005', 'AC/DC', 'Australian rock band');

-- Inserting data into the album_artist table
INSERT INTO `album_artist` (`album_id`, `artist_id`)
VALUES
('ALB0001', 'ART0001'),
('ALB0002', 'ART0002'),
('ALB0003', 'ART0003'),
('ALB0004', 'ART0004'),
('ALB0005', 'ART0005');

-- Inserting data into the genre table
INSERT INTO `genre` (`genre_id`, `genre_name`)
VALUES
('GEN0001', 'Pop'),
('GEN0002', 'Rock'),
('GEN0003', 'Soul'),
('GEN0004', 'Blues'),
('GEN0005', 'Country');

-- Inserting data into the language table
INSERT INTO `language` (`language_id`, `language_name`) VALUES
('en', 'English'),
('fr', 'French'),
('es', 'Spanish'),
('de', 'German'),
('zh', 'Chinese'),
('jp', 'Japanese');

-- Inserting data into the track table
INSERT INTO `track` (`track_id`, `track_name`, `time_length`, `lyrics`, `language_id`, `source`, `album_id`, `genre_id`) VALUES
('TR0001', 'Bohemian Rhapsody', 354, 'Is this the real life? Is this just fantasy? Caught in a landslide...', 'en', 'https://www.youtube.com/watch?v=fJ9rUzIMcZQ', 'ALB0001', 'GEN0001'),
('TR0002', 'Billie Jean', 293, 'She was more like a beauty queen from a movie scene...', 'en', 'https://www.youtube.com/watch?v=Kr4EQOoqPE0', 'ALB0001', 'GEN0002'),
('TR0003', 'Los Tamales', 207, 'En la esquina de mi barrio venden los tamales, los tamales que me gustan a mi...', 'es', 'https://www.youtube.com/watch?v=6J3y7vq8w1M', 'ALB0003', 'GEN0003'),
('TR0004', 'Shape of You', 235, 'The club isn''t the best place to find a lover...', 'en', 'https://www.youtube.com/watch?v=JGwWNGJdvx8', 'ALB0001', 'GEN0001'),
('TR0005', 'First Love', 257, '最後のキスはタバコの flavor がした ニガくてせつない香り...', 'jp', 'https://www.youtube.com/watch?v=o1sUaVJUeB0', 'ALB0002', 'GEN0001');

-- Inserting data into the track_artist table
INSERT INTO `track_artist` (`track_id`, `artist_id`) VALUES
('TR0001', 'ART0001'),
('TR0002', 'ART0002'),
('TR0003', 'ART0003'),
('TR0004', 'ART0004'),
('TR0005', 'ART0005');

-- Inserting data into the user table
INSERT INTO `user`(`user_id`, `user_name`, `email`, `password`, `avatar`, `register_datetime`, `last_login_datetime`) VALUES 
('USR0001', 'John Doe', 'johndoe@example.com', 'password123', 'https://example.com/avatar1.jpg', '2022-01-01 10:00:00', '2022-01-01 12:00:00'),
('USR0002', 'Jane Smith', 'janesmith@example.com', 'letmein', 'https://example.com/avatar2.jpg', '2022-01-02 11:00:00', '2022-01-03 15:00:00'),
('USR0003', 'Bob Johnson', 'bobjohnson@example.com', 'password1234', 'https://example.com/avatar3.jpg', '2022-01-03 12:00:00', '2022-01-04 14:00:00'),
('USR0004', 'Alice Johnson', 'alice.johnson@example.com', 'password123', 'https://example.com/avatars/alice.jpg', '2022-01-01 12:00:00', '2022-01-01 12:00:00'),
('USR0005', 'Bob Smith', 'bob.smith@example.com', 'abc123', 'https://example.com/avatars/bob.jpg', '2022-01-02 09:30:00', '2022-01-03 14:15:00');
-- Register
CALL `register_user`('Sarah Lee', 'sarahlee@example.com', 'mypassword', 'https://example.com/avatars/lee.jpg');
-- Test if email duplicates
-- CALL `register_user`('Test User', 'johndoe@example.com', 'testpwd', 'https://example.com/testavatar.jpg');

-- Inserting data into the playlist table
INSERT INTO `playlist` (`playlist_id`, `playlist_name`, `playlist_bio`, `created_date`, `user_id`)
VALUES
('PL0001', 'My Top Hits', 'A playlist of my all-time favorite songs', '2022-01-01 00:00:00', 'USR0001'),
('PL0002', 'Road Trip Mix', 'A collection of upbeat songs for the open road', '2022-02-15 10:30:00', 'USR0002'),
('PL0003', 'Chillout Vibes', 'Perfect for relaxing after a long day', '2022-03-05 18:45:00', 'USR0003'),
('PL0004', 'Workout Jams', 'Get pumped up with these high-energy tracks', '2022-04-10 09:00:00', 'USR0002'),
('PL0005', 'Throwback Hits', 'Take a trip down memory lane with these classic tunes', '2022-05-20 15:15:00', 'USR0001');

-- Inserting data into the playlist_track table
INSERT INTO `playlist_track` (`playlist_id`, `track_id`) VALUES 
('PL0001', 'TR0001'),
('PL0001', 'TR0002'),
('PL0002', 'TR0003'),
('PL0002', 'TR0004'),
('PL0003', 'TR0005');

-- Inserting data into the suscription table
INSERT INTO `subscription` (`subscription_id`, `duration`, `subscribe_date`, `price`, `payment_method`, `is_autosubscription`, `user_id`) VALUES
('SUBS0001', 30, '2022-01-01 00:00:00', 19.99, 'Credit Card', true, 'USR0001'),
('SUBS0002', 60, '2022-02-15 10:30:00', 29.99, 'PayPal', false, 'USR0002'),
('SUBS0003', 90, '2022-03-10 08:15:00', 39.99, 'Debit Card', true, 'USR0003'),
('SUBS0004', 30, '2022-04-20 14:00:00', 19.99, 'Credit Card', true, 'USR0004'),
('SUBS0005', 180, '2022-05-05 19:45:00', 49.99, 'PayPal', true, 'USR0005');

-- Inserting data into the album_comment table
INSERT INTO `album_comment` (`albcmt_id`, `album_id`, `user_id`, `cmt_text`, `cmt_datetime`, `like_num`)
VALUES 
('ALBCM001', 'ALB0001', 'USR0001', 'This album is amazing!', '2022-02-01 10:30:00', 10),
('ALBCM002', 'ALB0001', 'USR0002', 'I really enjoyed the melodies in this album.', '2022-02-02 13:45:00', 5),
('ALBCM003', 'ALB0002', 'USR0003', 'This album has been on repeat for me.', '2022-03-15 08:20:00', 2),
('ALBCM004', 'ALB0003', 'USR0004', 'I think the lyrics in this album are really deep.', '2022-04-03 14:00:00', 0),
('ALBCM005', 'ALB0004', 'USR0002', 'Not my favorite album, but still has some good songs.', '2022-04-10 19:30:00', 1);

-- Inserting data into the track_comment table
INSERT INTO `track_comment` (`tracmt_id`, `track_id`, `user_id`, `cmt_text`, `cmt_datetime`, `like_num`) VALUES
('TRCM0001', 'TR0001', 'USR0001', 'This track is amazing!', '2022-01-01 10:00:00', 10),
('TRCM0002', 'TR0002', 'USR0002', 'The lyrics are so deep and meaningful.', '2022-01-02 14:30:00', 5),
('TRCM0003', 'TR0003', 'USR0003', 'I love this track! It always puts me in a good mood.', '2022-01-03 09:45:00', 15),
('TRCM0004', 'TR0004', 'USR0004', 'The guitar solo in this track is amazing!', '2022-01-04 16:20:00', 7),
('TRCM0005', 'TR0005', 'USR0005', 'This track is perfect for relaxing after a long day.', '2022-01-05 20:15:00', 12);

-- Inserting data into the album_reply table
INSERT INTO `album_reply` (`albrpl_id`, `reply_text`, `albcmt_id`, `user_id`, `reply_datetime`, `like_num`)
VALUES
('ALBR0001', 'Thank you for your kind words!', 'ALBCM001', 'USR0001', '2022-02-01 12:34:56', 10),
('ALBR0002', 'Glad you enjoyed the album!', 'ALBCM001', 'USR0002', '2022-02-02 08:23:45', 5),
('ALBR0003', 'I appreciate your support!', 'ALBCM002', 'USR0003', '2022-02-03 14:56:23', 3),
('ALBR0004', 'Thank you for listening!', 'ALBCM003', 'USR0004', '2022-02-04 17:12:34', 7),
('ALBR0005', 'Your comment made my day!', 'ALBCM004', 'USR0005', '2022-02-05 09:45:12', 12);

-- Inserting data into the track_reply table
INSERT INTO `track_reply` (`trarpl_id`, `reply_text`, `tracmt_id`, `user_id`, `reply_datetime`, `like_num`) VALUES
('TRR0001', 'Thanks for your comment!', 'TRCM0001', 'USR0001', '2022-01-01 12:00:00', 10),
('TRR0002', 'I totally agree with you', 'TRCM0002', 'USR0002', '2022-01-02 13:00:00', 5),
('TRR0003', 'Can you explain more about what you mean?', 'TRCM0003', 'USR0003', '2022-01-03 14:00:00', 0),
('TRR0004', 'Thanks for your feedback!', 'TRCM0002', 'USR0004', '2022-01-04 15:00:00', 2),
('TRR0005', 'I think you misunderstood the point', 'TRCM0004', 'USR0002', '2022-01-05 16:00:00', 3);

-- Inserting data into the like_music table
INSERT INTO `like_music` (`user_id`, `track_id`, `like_datetime`) VALUES
('USR0001', 'TR0001', '2022-03-15 14:25:00'),
('USR0001', 'TR0003', '2022-03-17 10:10:00'),
('USR0002', 'TR0002', '2022-03-16 18:30:00'),
('USR0002', 'TR0005', '2022-03-18 09:45:00'),
('USR0003', 'TR0001', '2022-03-19 11:20:00'),
('USR0003', 'TR0004', '2022-03-20 14:50:00'),
('USR0004', 'TR0003', '2022-03-21 16:15:00'),
('USR0004', 'TR0005', '2022-03-22 19:05:00'),
('USR0005', 'TR0002', '2022-03-23 10:40:00'),
('USR0005', 'TR0004', '2022-03-24 13:55:00');

-- Inserting data into the like_album table
INSERT INTO `like_album` (`user_id`, `album_id`, `like_datetime`) VALUES
('USR0001', 'ALB0001', '2022-03-15 14:25:00'),
('USR0001', 'ALB0003', '2022-03-17 10:10:00'),
('USR0002', 'ALB0002', '2022-03-16 18:30:00'),
('USR0002', 'ALB0005', '2022-03-18 09:45:00'),
('USR0003', 'ALB0001', '2022-03-19 11:20:00'),
('USR0003', 'ALB0004', '2022-03-20 14:50:00'),
('USR0004', 'ALB0003', '2022-03-21 16:15:00'),
('USR0004', 'ALB0005', '2022-03-22 19:05:00'),
('USR0005', 'ALB0002', '2022-03-23 10:40:00'),
('USR0005', 'ALB0004', '2022-03-24 13:55:00');

-- Inserting data into the play table
INSERT INTO `play` (`play_id`, `track_id`, `user_id`, `play_datetime`) VALUES
('PLAY0001', 'TR0001', 'USR0001', '2022-12-22 09:15:00'),
('PLAY0002', 'TR0005', 'USR0005', '2022-12-10 15:30:00'),
('PLAY0003', 'TR0002', 'USR0002', '2022-12-01 13:45:00'),
('PLAY0004', 'TR0004', 'USR0002', '2022-12-05 20:10:00'),
('PLAY0005', 'TR0005', 'USR0003', '2023-03-12 11:55:00'),
('PLAY0006', 'TR0002', 'USR0003', '2023-02-18 16:40:00'),
('PLAY0007', 'TR0003', 'USR0004', '2023-03-06 14:20:00'),
('PLAY0008', 'TR0005', 'USR0004', '2023-03-23 09:05:00'),
('PLAY0009', 'TR0001', 'USR0005', '2023-02-17 12:50:00'),
('PLAY0010', 'TR0004', 'USR0005', '2023-03-12 18:25:00'),
('PLAY0011', 'TR0004', 'USR0005', '2023-03-29 18:25:00'),
('PLAY0012', 'TR0004', 'USR0005', '2023-03-29 18:25:00'),
('PLAY0013', 'TR0005', 'USR0005', '2023-01-10 15:30:00'),
('PLAY0014', 'TR0002', 'USR0002', '2023-02-01 13:45:00'),
('PLAY0015', 'TR0004', 'USR0002', '2023-03-05 20:10:00'),
('PLAY0016', 'TR0005', 'USR0003', '2023-02-12 11:55:00'),
('PLAY0017', 'TR0002', 'USR0003', '2023-03-28 16:40:00'),
('PLAY0018', 'TR0003', 'USR0004', '2023-03-26 14:20:00'),
('PLAY0019', 'TR0005', 'USR0004', '2023-03-27 09:05:00'),
('PLAY0020', 'TR0001', 'USR0005', '2023-03-27 12:50:00'),
('PLAY0021', 'TR0004', 'USR0005', '2023-03-29 19:25:00'),
('PLAY0022', 'TR0004', 'USR0005', '2023-03-29 18:28:00'),
('PLAY0023', 'TR0004', 'USR0005', '2023-03-29 18:25:00');
