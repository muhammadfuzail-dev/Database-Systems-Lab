DROP TABLE IF EXISTS Comments;
DROP TABLE IF EXISTS Subscriptions;
DROP TABLE IF EXISTS Videos;
DROP TABLE IF EXISTS Channels;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    country VARCHAR(50),
    joined_date DATE NOT NULL
);

CREATE TABLE Channels (
    channel_id SERIAL PRIMARY KEY,
    channel_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    subscriber_count INT DEFAULT 0,
    user_id INT NOT NULL,
    status VARCHAR(20),
    created_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Videos (
    video_id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    category VARCHAR(50),
    views INT DEFAULT 0,
    ad_revenue NUMERIC(8,2) NOT NULL,
    duration_seconds INT,
    upload_date DATE,
    channel_id INT NOT NULL,
    FOREIGN KEY (channel_id) REFERENCES Channels(channel_id)
);

CREATE TABLE Subscriptions (
    subscription_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    channel_id INT NOT NULL,
    subscribed_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (channel_id) REFERENCES Channels(channel_id),
    UNIQUE (user_id, channel_id)
);

CREATE TABLE Comments (
    comment_id SERIAL PRIMARY KEY,
    video_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    likes INT DEFAULT 0,
    comment_text VARCHAR(255),
    comment_date DATE NOT NULL,
    FOREIGN KEY (video_id) REFERENCES Videos(video_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Users (name, email, country, joined_date) VALUES
('Bilal Ahmed', 'bilal@gmail.com', 'Pakistan', '2021-03-15'),
('Ayesha Noor', 'ayesha@gmail.com', 'India', '2020-07-22'),
('Hamza Khan', 'hamza@gmail.com', 'UAE', '2019-11-05'),
('Mehak Fatima', 'mehak@gmail.com', 'Pakistan', '2022-01-10'),
('Usman Tariq', 'usman@gmail.com', 'UK', '2021-09-18'),
('Zara Sheikh', 'zara@gmail.com', 'Canada', '2020-02-28');

INSERT INTO Channels (channel_name, category, subscriber_count, user_id, status, created_date) VALUES
('CodeWithBilal', 'Technology', 150000, 1, 'Active', '2019-05-01'),
('Ayesha Vlogs', 'Vlog', 320000, 2, 'Active', '2018-09-12'),
('Hamza Gaming', 'Gaming', 480000, 3, 'Active', '2017-03-20'),
('Mehak Cooks', 'Food', 95000, 4, 'Suspended', '2020-06-15'),
('Usman Comedy Hub', 'Comedy', 210000, 5, 'Active', '2019-11-02'),
('Zara Music', 'Music', 60000, 6, 'Active', '2021-01-08');

INSERT INTO Videos (title, category, views, ad_revenue, duration_seconds, upload_date, channel_id) VALUES
('Learn SQL in 30 Minutes', 'Technology', 620000, 1200.00, 1800, '2023-01-10', 1),
('My Morning Routine', 'Vlog', 410000, 900.00, 600, '2023-02-05', 2),
('Insane Boss Fight Highlights', 'Gaming', 980000, 2200.00, 1200, '2023-01-20', 3),
('5-Minute Biryani Recipe', 'Food', 150000, 400.00, 420, '2023-03-01', 4),
('Try Not To Laugh Challenge', 'Comedy', 730000, 1600.00, 540, '2023-02-18', 5),
('Chill Lofi Mix', 'Music', 260000, 500.00, 3600, '2023-01-25', 6),
('Top 10 VS Code Extensions', 'Technology', 340000, 700.00, 900, '2023-04-02', 1),
('A Day In My Life', 'Vlog', 180000, 350.00, 720, '2023-03-15', 2),
('Speedrun World Record', 'Gaming', 560000, 1100.00, 1500, '2023-02-27', 3),
('Stand-Up Comedy Special', 'Comedy', 890000, 1950.00, 2400, '2023-04-10', 5);

INSERT INTO Subscriptions (user_id, channel_id, subscribed_date) VALUES
(2, 1, '2022-01-05'),
(3, 1, '2022-02-11'),
(1, 3, '2021-12-01'),
(4, 2, '2022-03-20'),
(5, 3, '2021-11-15'),
(6, 5, '2022-04-02'),
(1, 5, '2022-05-19'),
(2, 6, '2022-06-08');

INSERT INTO Comments (video_id, user_id, rating, likes, comment_text, comment_date) VALUES
(1, 2, 5, 340, 'Best SQL tutorial I have watched', '2023-01-15'),
(1, 3, 4, 210, 'Very clear explanation', '2023-01-16'),
(3, 1, 5, 890, 'That boss fight was insane', '2023-01-22'),
(3, 5, 5, 455, 'Watched this three times already', '2023-01-25'),
(5, 6, 4, 302, 'I actually laughed out loud', '2023-02-19'),
(5, 1, 5, 178, 'This made my whole day', '2023-02-20'),
(6, 2, 3, 64, 'Nice for studying', '2023-01-26'),
(10, 4, 5, 511, 'Best stand-up special of the year', '2023-04-11');
