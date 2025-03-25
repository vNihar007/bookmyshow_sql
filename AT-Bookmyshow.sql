CREATE DATABASE bookmyshow ;
USE bookmyshow;
/*
Theatre (Stores details of theatres)

Movie (Stores details of movies)

Show (Stores details of movie screenings)

Booking (Stores details of ticket bookings)

User (Stores details of users booking tickets)

Seat (Stores seat-related information)
*/

CREATE TABLE Theatre (
    theatre_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL
);

CREATE TABLE Movie (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    duration INT NOT NULL, -- Duration in minutes
    language VARCHAR(50),
    genre VARCHAR(100)
);

CREATE TABLE Movieshow (
    show_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT,
    theatre_id INT,
    show_date DATE,
    start_time TIME,
    end_time TIME,
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id),
    FOREIGN KEY (theatre_id) REFERENCES Theatre(theatre_id)
);

CREATE TABLE User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20) UNIQUE
);

CREATE TABLE Booking (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    show_id INT,
    seat_number VARCHAR(10),
    booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (show_id) REFERENCES Movieshow(show_id)
);

CREATE TABLE Seat (
    seat_id INT PRIMARY KEY AUTO_INCREMENT,
    theatre_id INT,
    seat_number VARCHAR(10),
    seat_type VARCHAR(50),
    FOREIGN KEY (theatre_id) REFERENCES Theatre(theatre_id)
);

-- Sample Data
-- Insert Theatres 
INSERT INTO Theatre (name, location) VALUES 
('PVR Hyderabad', 'Hyderabad'),
('INOX GVK One', 'Hyderabad'),
('AMB Cinemas', 'Hyderabad'),
('Asian CineSquare', 'Secunderabad'),
('Sree Ramulu Theatre', 'Vijayawada');

-- Insert Movies 
INSERT INTO Movie (title, duration, language, genre) VALUES 
('RRR', 187, 'Telugu', 'Action'),
('Pushpa: The Rise', 179, 'Telugu', 'Action'),
('Baahubali 2', 171, 'Telugu', 'Fantasy'),
('Ala Vaikunthapurramuloo', 165, 'Telugu', 'Drama'),
('Sarileru Neekevvaru', 169, 'Telugu', 'Action');

-- Insert Movie Shows
INSERT INTO MovieShow (movie_id, theatre_id, show_date, start_time, end_time) VALUES 
(1, 1, '2025-03-25', '10:00:00', '13:07:00'),
(2, 1, '2025-03-25', '14:00:00', '16:59:00'),
(3, 2, '2025-03-25', '12:00:00', '14:51:00'),
(4, 3, '2025-03-25', '16:00:00', '18:45:00'),
(5, 4, '2025-03-25', '19:00:00', '21:49:00');

-- Insert Users (Indian names)
INSERT INTO User (name, email, phone) VALUES 
('Varun Reddy', 'varun.reddy@example.com', '9876543210'),
('Sai Kumar', 'sai.kumar@example.com', '9876543211'),
('Anusha Shetty', 'anusha.shetty@example.com', '9876543212'),
('Kiran Kumar', 'kiran.kumar@example.com', '9876543213'),
('Priya Sharma', 'priya.sharma@example.com', '9876543214');

-- Insert Bookings
INSERT INTO Booking (user_id, show_id, seat_number) VALUES 
(1, 1, 'A10'),
(2, 1, 'B15'),
(3, 2, 'C20'),
(4, 3, 'D05'),
(5, 4, 'E12');

-- Insert Seats
INSERT INTO Seat (theatre_id, seat_number, seat_type) VALUES 
(1, 'A10', 'Premium'),
(1, 'B15', 'Regular'),
(2, 'C20', 'Premium'),
(3, 'D05', 'VIP'),
(4, 'E12', 'Regular');

-- PERFORMING AN QUERY OPERATION : 
-- 1
SELECT 
    t.name AS TheatreName,
    m.title AS MovieName,
    m.language AS Language,
    m.genre AS Genre,  
    ms.start_time AS ShowTime
FROM MovieShow ms
JOIN Theatre t ON ms.theatre_id = t.theatre_id
JOIN Movie m ON ms.movie_id = m.movie_id
WHERE t.theatre_id = 1 AND ms.show_date = '2025-03-25'
ORDER BY ms.start_time;

-- 2  (all movies playing in all theatres)
SELECT 
    t.name AS TheatreName,
    t.location AS TheatreLocation,
    m.title AS MovieName,
    m.language AS Language,
    m.genre AS Genre,
    ms.show_date AS ShowDate,
    ms.start_time AS ShowTime,
    ms.end_time AS EndTime
FROM MovieShow ms
JOIN Theatre t ON ms.theatre_id = t.theatre_id
JOIN Movie m ON ms.movie_id = m.movie_id
ORDER BY t.name, ms.show_date, ms.start_time;


