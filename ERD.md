# ERD — Football Ticket Booking System

## Public Diagram Link

🔗 **[View ERD on draw.io](https://app.diagrams.net)**
*(Link will be updated once published)*

---

## Relationships

| Relationship | Type | Description |
|---|---|---|
| users → bookings | One to Many (1:N) | One user can place many bookings |
| bookings → matches | Many to One (N:1) | Many bookings link to one match |
| booking row | Logical 1:1 | Each row maps exactly one user to one match |

---

## Table Schemas

### users
| Column | Type | Constraint |
|---|---|---|
| user_id | SERIAL | PRIMARY KEY |
| full_name | VARCHAR(100) | NOT NULL |
| email | VARCHAR(100) | UNIQUE, NOT NULL |
| role | VARCHAR(50) | CHECK: Ticket Manager / Football Fan |
| phone_number | VARCHAR(20) | nullable |

### matches
| Column | Type | Constraint |
|---|---|---|
| match_id | SERIAL | PRIMARY KEY |
| fixture | VARCHAR(150) | NOT NULL |
| tournament_category | VARCHAR(100) | NOT NULL |
| base_ticket_price | NUMERIC(10,2) | NOT NULL |
| match_status | VARCHAR(50) | CHECK: Available / Selling Fast / Sold Out / Postponed |

### bookings
| Column | Type | Constraint |
|---|---|---|
| booking_id | SERIAL | PRIMARY KEY |
| user_id | INT | FK → users(user_id) ON DELETE CASCADE |
| match_id | INT | FK → matches(match_id) ON DELETE CASCADE |
| seat_number | VARCHAR(10) | nullable |
| payment_status | VARCHAR(20) | CHECK: Pending / Confirmed / Cancelled / Refunded |
| total_cost | NUMERIC(10,2) | NOT NULL |
