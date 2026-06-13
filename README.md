# Football Ticket Booking System

A relational database design and SQL query project for a simplified Football Ticket Booking System.

## Author

**Najmul Hasan**
GitHub: [@najmulcodes](https://github.com/najmulcodes)

---

## Project Structure

```
L2B7A3/
├── QUERY.sql     -- Schema, seed data, and all 7 SQL queries
├── ERD.md        -- ERD diagram link and relationship breakdown
└── README.md     -- Project overview
```

---

## Part 1 — ERD Design

See **ERD.md** for the public diagram link and full table descriptions.

**Entities:** `users`, `matches`, `bookings`

**Relationships:**
- One `user` → Many `bookings` (1:N)
- Many `bookings` → One `match` (N:1)
- Each booking row = one user mapped to one match (logical 1:1)

---

## Part 2 — SQL Queries

All 7 queries are written in `QUERY.sql` along with the schema and seed data.

| # | Task | Concept |
|---|------|---------|
| 1 | Filter Champions League available matches | `WHERE` |
| 2 | Search by name pattern (case-insensitive) | `ILIKE` |
| 3 | Find NULL payment status, replace label | `IS NULL`, `COALESCE` |
| 4 | Join bookings with user name and fixture | `INNER JOIN` |
| 5 | List all users including those without bookings | `LEFT JOIN` |
| 6 | Bookings above average total cost | Scalar subquery, `AVG` |
| 7 | 2nd and 3rd most expensive matches | `ORDER BY`, `LIMIT`, `OFFSET` |

---

## How to Run

```bash
psql -U postgres -d your_database -f QUERY.sql
```

Or paste `QUERY.sql` into pgAdmin / DBeaver query tool.
