-- ================================================================
-- Football Ticket Booking System
-- Author : Najmul Hasan
-- GitHub : https://github.com/najmulcodes/L2B7A3
-- ================================================================


-- ================================================================
-- SCHEMA: users
-- ================================================================

CREATE TABLE IF NOT EXISTS users (
    user_id      SERIAL PRIMARY KEY,
    full_name    VARCHAR(100) NOT NULL,
    email        VARCHAR(100) UNIQUE NOT NULL,
    role         VARCHAR(50)  NOT NULL CHECK (role IN ('Ticket Manager', 'Football Fan')),
    phone_number VARCHAR(20)
);


-- ================================================================
-- SCHEMA: matches
-- ================================================================

CREATE TABLE IF NOT EXISTS matches (
    match_id             SERIAL PRIMARY KEY,
    fixture              VARCHAR(150) NOT NULL,
    tournament_category  VARCHAR(100) NOT NULL,
    base_ticket_price    NUMERIC(10, 2) NOT NULL,
    match_status         VARCHAR(50)  NOT NULL CHECK (match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);


-- ================================================================
-- SCHEMA: bookings  (FK → users, FK → matches)
-- ================================================================

CREATE TABLE IF NOT EXISTS bookings (
    booking_id     SERIAL PRIMARY KEY,
    user_id        INT  NOT NULL REFERENCES users(user_id)   ON DELETE CASCADE,
    match_id       INT  NOT NULL REFERENCES matches(match_id) ON DELETE CASCADE,
    seat_number    VARCHAR(10),
    payment_status VARCHAR(20) CHECK (payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
    total_cost     NUMERIC(10, 2) NOT NULL
);


-- ================================================================
-- SEED: users
-- ================================================================

INSERT INTO users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan',   '+8801711111111'),
(2, 'Asif Haque',    'asif@mail.com',   'Football Fan',   '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara',    'jannat@mail.com', 'Football Fan',    NULL);


-- ================================================================
-- SEED: matches
-- ================================================================

INSERT INTO matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool',    'Premier League',   120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG',     'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan',  'Serie A',           90.00, 'Sold Out'),
(105, 'Juventus vs Roma',         'Serie A',           80.00, 'Available');


-- ================================================================
-- SEED: bookings
-- booking_id 504 has NULL seat_number and NULL payment_status
-- ================================================================

INSERT INTO bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101,  NULL,   NULL,       150.00),
(505, 3, 102, 'C-20', 'Pending',   120.00);


-- ================================================================
-- QUERY 1
-- Retrieve all upcoming football matches belonging to the
-- 'Champions League' where the match status is 'Available'.
-- ================================================================

SELECT
    match_id,
    fixture,
    base_ticket_price
FROM matches
WHERE tournament_category = 'Champions League'
  AND match_status = 'Available';


-- ================================================================
-- QUERY 2
-- Search for users whose full name starts with 'Tanvir' OR
-- contains 'Haque' — case-insensitive.
-- Concepts: ILIKE
-- ================================================================

SELECT
    user_id,
    full_name,
    email
FROM users
WHERE full_name ILIKE 'Tanvir%'
   OR full_name ILIKE '%Haque%';


-- ================================================================
-- QUERY 3
-- Retrieve bookings where payment_status is NULL,
-- replacing the missing value with 'Action Required'.
-- Concepts: IS NULL, COALESCE
-- ================================================================

SELECT
    booking_id,
    user_id,
    match_id,
    COALESCE(payment_status, 'Action Required') AS systematic_status
FROM bookings
WHERE payment_status IS NULL;


-- ================================================================
-- QUERY 4
-- Retrieve booking details joined with user full name
-- and match fixture.
-- Concepts: INNER JOIN
-- ================================================================

SELECT
    b.booking_id,
    u.full_name,
    m.fixture,
    b.total_cost
FROM bookings b
INNER JOIN users   u ON b.user_id  = u.user_id
INNER JOIN matches m ON b.match_id = m.match_id;
