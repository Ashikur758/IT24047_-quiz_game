-- Sirajganj District Quiz
-- Run this file once in MySQL to create the database and the 20 starter questions.

CREATE DATABASE IF NOT EXISTS sirajganj_quiz_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE sirajganj_quiz_db;

-- Drop in reverse order because of foreign keys
DROP TABLE IF EXISTS quiz_answers;
DROP TABLE IF EXISTS quiz_attempts;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS players;

CREATE TABLE players (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    phone VARCHAR(30),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE questions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    question_text TEXT NOT NULL,
    option_a VARCHAR(500) NOT NULL,
    option_b VARCHAR(500) NOT NULL,
    option_c VARCHAR(500) NOT NULL,
    option_d VARCHAR(500) NOT NULL,
    correct_option CHAR(1) NOT NULL,
    category VARCHAR(50) NOT NULL,
    difficulty VARCHAR(20) DEFAULT 'Easy',
    explanation TEXT,
    source_url VARCHAR(1000),
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE quiz_attempts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT NOT NULL,
    total_questions INT NOT NULL,
    correct_answers INT NOT NULL,
    wrong_answers INT NOT NULL,
    score INT NOT NULL,
    percentage DECIMAL(5,2) NOT NULL,
    started_at TIMESTAMP NULL,
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE
);

CREATE TABLE quiz_answers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    attempt_id INT NOT NULL,
    question_id INT NOT NULL,
    selected_option CHAR(1),
    correct_option CHAR(1) NOT NULL,
    is_correct BOOLEAN NOT NULL,
    FOREIGN KEY (attempt_id) REFERENCES quiz_attempts(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);

CREATE INDEX idx_questions_active ON questions (active);
CREATE INDEX idx_questions_category ON questions (category);
CREATE INDEX idx_attempts_player ON quiz_attempts (player_id);
CREATE INDEX idx_answers_attempt ON quiz_answers (attempt_id);

-- 20 starter questions about Sirajganj District.
-- Correct option is always A, B, C, or D.

INSERT INTO questions (
    question_text, option_a, option_b, option_c, option_d,
    correct_option, category, difficulty, explanation, source_url, active
) VALUES
(
    'Which crop is listed among the major agricultural crops of Sirajganj District?',
    'Paddy', 'Tea', 'Rubber', 'Coffee',
    'A', 'Crops & Agriculture', 'Easy',
    'BBS identifies paddy as one of the major agricultural crops of Sirajganj.',
    'https://nsds.bbs.gov.bd/storage/files/1/Publications/PHC_2011%20Community%20Report/RAJSHAHI%20DIVISION/SIRAJGANJ.pdf', TRUE
),
(
    'Which fibre crop is listed as a major crop of Sirajganj?',
    'Jute', 'Cocoa', 'Olive', 'Tobacco',
    'A', 'Crops & Agriculture', 'Easy',
    'BBS lists jute among the major agricultural crops of Sirajganj District.',
    'https://nsds.bbs.gov.bd/storage/files/1/Publications/PHC_2011%20Community%20Report/RAJSHAHI%20DIVISION/SIRAJGANJ.pdf', TRUE
),
(
    'Which cereal crop, besides paddy, is listed among Sirajganj''s major crops?',
    'Wheat', 'Tea', 'Rubber', 'Coconut',
    'A', 'Crops & Agriculture', 'Easy',
    'Wheat is included in the BBS list of major crops of Sirajganj.',
    'https://nsds.bbs.gov.bd/storage/files/1/Publications/PHC_2011%20Community%20Report/RAJSHAHI%20DIVISION/SIRAJGANJ.pdf', TRUE
),
(
    'Which oilseed crop is listed among the major crops of Sirajganj?',
    'Mustard seed', 'Coffee', 'Cocoa', 'Tea',
    'A', 'Crops & Agriculture', 'Easy',
    'Mustard seed is listed among the major agricultural crops of Sirajganj.',
    'https://nsds.bbs.gov.bd/storage/files/1/Publications/PHC_2011%20Community%20Report/RAJSHAHI%20DIVISION/SIRAJGANJ.pdf', TRUE
),
(
    'Which of the following is also listed as a major crop of Sirajganj District?',
    'Sugarcane', 'Rubber', 'Tea', 'Cocoa',
    'A', 'Crops & Agriculture', 'Easy',
    'BBS includes sugarcane in the major crop list for Sirajganj District.',
    'https://nsds.bbs.gov.bd/storage/files/1/Publications/PHC_2011%20Community%20Report/RAJSHAHI%20DIVISION/SIRAJGANJ.pdf', TRUE
),
(
    'Which vegetable crop is listed among Sirajganj''s major agricultural crops?',
    'Onion', 'Tea', 'Coconut', 'Rubber',
    'A', 'Crops & Agriculture', 'Medium',
    'Onion is included in the BBS list of major agricultural crops of Sirajganj.',
    'https://nsds.bbs.gov.bd/storage/files/1/Publications/PHC_2011%20Community%20Report/RAJSHAHI%20DIVISION/SIRAJGANJ.pdf', TRUE
),
(
    'Which public university is located in Shahjadpur, Sirajganj?',
    'Rabindra University, Bangladesh', 'University of Dhaka', 'Rajshahi University', 'Jahangirnagar University',
    'A', 'Academic Institutions', 'Easy',
    'The official Rabindra University website gives its address as Shahjadpur, Sirajganj.',
    'https://www.rub.ac.bd/', TRUE
),
(
    'Rabindra University, Bangladesh is named after which Nobel Prize-winning Bengali poet?',
    'Rabindranath Tagore', 'Kazi Nazrul Islam', 'Jibanananda Das', 'Michael Madhusudan Dutt',
    'A', 'Academic Institutions', 'Easy',
    'The university is named after Nobel laureate poet Rabindranath Tagore.',
    'https://www.rub.ac.bd/about-us.php?page=about', TRUE
),
(
    'In which upazila of Sirajganj is Rabindra University, Bangladesh located?',
    'Shahjadpur', 'Kazipur', 'Ullahpara', 'Tarash',
    'A', 'Academic Institutions', 'Easy',
    'The official university website identifies Shahjadpur, Sirajganj as its location.',
    'https://www.rub.ac.bd/about-us.php?page=about', TRUE
),
(
    'Which university is listed by Sirajganj District as being in Enayetpur?',
    'Khaja Yunus Ali University', 'Rabindra University', 'University of Rajshahi', 'Bangladesh University of Engineering and Technology',
    'A', 'Academic Institutions', 'Medium',
    'The Sirajganj District official website lists Khaja Yunus Ali University at Enayetpur, Sirajganj.',
    'https://sirajganj.gov.bd/pages/static-pages/69915efd733eeff6f34d3ad0', TRUE
),
(
    'How many government polytechnic institutes are listed in the Sirajganj District education information?',
    '1', '2', '3', '4',
    'A', 'Academic Institutions', 'Medium',
    'The official Sirajganj District education page lists 1 government polytechnic institute.',
    'https://sirajganj.gov.bd/pages/static-pages/697fbb0c35ce18e1c06cbb42', TRUE
),
(
    'How many upazilas does Sirajganj District have?',
    '9', '8', '10', '12',
    'A', 'Geography', 'Easy',
    'The official national upazila list and BBS community report identify 9 upazilas in Sirajganj District.',
    'https://bangladesh.gov.bd/views/upazila-list', TRUE
),
(
    'Which river is the major river associated with Sirajganj District?',
    'Jamuna', 'Karnaphuli', 'Surma', 'Sangu',
    'A', 'Geography', 'Easy',
    'BBS identifies the Jamuna as one of the main rivers of Sirajganj District.',
    'https://nsds.bbs.gov.bd/storage/files/1/Publications/PHC_2011%20Community%20Report/RAJSHAHI%20DIVISION/SIRAJGANJ.pdf', TRUE
),
(
    'Which of the following is one of the main rivers of Sirajganj District besides the Jamuna?',
    'Baral', 'Karnaphuli', 'Sangu', 'Feni',
    'A', 'Geography', 'Medium',
    'BBS lists the Baral among the main rivers of Sirajganj District.',
    'https://nsds.bbs.gov.bd/storage/files/1/Publications/PHC_2011%20Community%20Report/RAJSHAHI%20DIVISION/SIRAJGANJ.pdf', TRUE
),
(
    'Which district lies to the east of Sirajganj according to the BBS district profile?',
    'Tangail', 'Natore', 'Pabna', 'Bogra',
    'A', 'Geography', 'Easy',
    'The BBS district profile identifies Tangail as the district on the east of Sirajganj.',
    'https://nsds.bbs.gov.bd/storage/files/1/Publications/PHC_2011%20Community%20Report/RAJSHAHI%20DIVISION/SIRAJGANJ.pdf', TRUE
),
(
    'Which district lies to the west of Sirajganj according to the BBS district profile?',
    'Natore', 'Tangail', 'Manikganj', 'Dhaka',
    'A', 'Geography', 'Easy',
    'The BBS district profile identifies Natore among the districts on the west of Sirajganj.',
    'https://nsds.bbs.gov.bd/storage/files/1/Publications/PHC_2011%20Community%20Report/RAJSHAHI%20DIVISION/SIRAJGANJ.pdf', TRUE
),
(
    'In which year was Sirajganj upgraded to a full-fledged district?',
    '1984', '1971', '1969', '1990',
    'A', 'Geography', 'Medium',
    'The BBS community report states that Sirajganj was upgraded to a district in 1984.',
    'https://nsds.bbs.gov.bd/storage/files/1/Publications/PHC_2011%20Community%20Report/RAJSHAHI%20DIVISION/SIRAJGANJ.pdf', TRUE
),
(
    'In which year was the Sirajganj subdivision established under Pabna District?',
    '1845', '1855', '1885', '1905',
    'A', 'Geography', 'Hard',
    'The BBS community report states that Sirajganj subdivision was established in 1845 under Pabna District.',
    'https://nsds.bbs.gov.bd/storage/files/1/Publications/PHC_2011%20Community%20Report/RAJSHAHI%20DIVISION/SIRAJGANJ.pdf', TRUE
),
(
    'What is the approximate total area of Sirajganj District given in the BBS district profile?',
    '2,402.05 square kilometres', '3,414.28 square kilometres', '1,383.66 square kilometres', '5,000 square kilometres',
    'A', 'Geography', 'Hard',
    'The BBS district profile gives the total area of Sirajganj Zila as 2,402.05 square kilometres.',
    'https://nsds.bbs.gov.bd/storage/files/1/Publications/PHC_2011%20Community%20Report/RAJSHAHI%20DIVISION/SIRAJGANJ.pdf', TRUE
),
(
    'Which of the following is one of the 9 upazilas of Sirajganj District?',
    'Kazipur', 'Trishal', 'Madhupur', 'Singair',
    'A', 'Geography', 'Easy',
    'Kazipur is one of the 9 upazilas of Sirajganj District.',
    'https://bangladesh.gov.bd/views/upazila-list', TRUE
);
