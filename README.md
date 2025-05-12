# plp_database_week_8_assignment

TITLE: Library Management System

OBJECTIVE:
To manage books, members, authors, borrowing transactions, and staff.

The database uses SQL to model real-world relationships like:
- Many-to-Many between Books and Authors
- One-to-Many between Members and Borrowings
- One-to-Many between Staff and Borrowings


ENTITIES AND RELATIONSHIPS:
Books

Authors

Members

Borrowings

Staff

Book_Authors (for many-to-many relationship between books and authors)

RELATIONSHIPS:
-One book can have many authors; one author can write many books → Many-to-Many

-One member can borrow many books → One-to-Many

-Each borrowing record is handled by one staff member → One-to-Many

-Each member has a unique email → Constraint: UNIQUE

How to Run / Setup the Project

## Prerequisites

- MySQL server installed (e.g. MySQL Workbench, XAMPP, or CLI)
- Basic SQL knowledge

### Steps

1. **Create the Database**:
   - Open your MySQL client.
   - Run the provided `.sql` script (`library_management.sql`).

2. **Insert Sample Data**:
   - Use the `INSERT INTO` statements provided to populate tables.

3. **Run Queries**:
   - Try SELECT queries to fetch books, authors, borrowings, etc.

ERD.pdf also included