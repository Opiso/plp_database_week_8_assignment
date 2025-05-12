-- Creating database

CREATE DATABASE IF NOT EXISTS libraryDB;
USE libraryDB;

-- Creating Staff Table
CREATE TABLE IF NOT EXISTS staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role VARCHAR(50),
    hire_date DATE
);

-- Creating Members Table
CREATE TABLE IF NOT EXISTS members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    membership_date DATE NOT NULL
);

-- Creating Authors Table
CREATE TABLE IF NOT EXISTS authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    bio TEXT
);

-- Creating Books Table
CREATE TABLE IF NOT EXISTS books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    published_year YEAR,
    genre VARCHAR(50),
    total_copies INT NOT NULL,
    available_copies INT NOT NULL
);

-- Creating Book_Authors (Many-to-Many)
CREATE TABLE IF NOT EXISTS book_Authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE
);

-- Creating Borrowings Table
CREATE TABLE IF NOT EXISTS borrowings (
    borrowing_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    staff_id INT,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE SET NULL
);

-- Insert into staff
INSERT INTO staff (name, email, role, hire_date) VALUES
('Alice Mwangi', 'alice@library.com', 'Librarian', '2020-01-15'),
('James Otieno', 'james@library.com', 'Assistant', '2021-06-20');

-- Insert into members
INSERT INTO members (name, email, phone, membership_date) VALUES
('Sarah Kamau', 'sarah.k@domain.com', '0712345678', '2023-01-10'),
('Brian Kiptoo', 'brian.kiptoo@domain.com', '0723456789', '2023-05-15'),
('Linda Wambui', 'linda.wambui@domain.com', '0734567890', '2023-08-21');

-- Insert into authors
INSERT INTO authors (name, bio) VALUES
('Ngũgĩ wa Thiong’o', 'Renowned Kenyan writer and academic.'),
('Chinua Achebe', 'Author of "Things Fall Apart", Nigerian novelist.'),
('Margaret Ogola', 'Kenyan author of "The River and the Source".');

-- Insert into books
INSERT INTO books (title, isbn, published_year, genre, total_copies, available_copies) VALUES
('The River and the Source', '9789966465258', 1994, 'Fiction', 5, 3),
('Things Fall Apart', '9780385474542', 1958, 'Historical Fiction', 4, 2),
('Petals of Blood', '9780435908444', 1977, 'Political Fiction', 6, 6);

-- Insert into book_Authors (Book <-> Author relationships)
-- The River and the Source → Margaret Ogola
INSERT INTO book_Authors (book_id, author_id) VALUES
(1, 3);

-- Things Fall Apart → Chinua Achebe
INSERT INTO book_Authors (book_id, author_id) VALUES
(2, 2);

-- Petals of Blood → Ngũgĩ wa Thiong’o
INSERT INTO book_Authors (book_id, author_id) VALUES
(3, 1);

-- Insert into borrowings
INSERT INTO borrowings (member_id, book_id, staff_id, borrow_date, return_date) VALUES
(1, 1, 1, '2024-12-01', NULL), -- Sarah borrowed "The River and the Source"
(2, 2, 2, '2024-12-03', '2025-01-03'), -- Brian borrowed "Things Fall Apart" and returned
(3, 1, 1, '2025-01-05', NULL); -- Linda borrowed "The River and the Source"


-- To See all books with their authors
SELECT b.title, a.name AS author
FROM Books b
JOIN Book_Authors ba ON b.book_id = ba.book_id
JOIN Authors a ON ba.author_id = a.author_id;

-- To See borrowings with member and book info
SELECT br.borrowing_id, m.name AS member, b.title AS book, s.name AS staff, br.borrow_date, br.return_date
FROM Borrowings br
JOIN Members m ON br.member_id = m.member_id
JOIN Books b ON br.book_id = b.book_id
JOIN Staff s ON br.staff_id = s.staff_id;