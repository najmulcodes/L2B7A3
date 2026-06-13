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
