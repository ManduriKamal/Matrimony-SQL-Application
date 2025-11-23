
-- MATRIMONY BASIC SQL APPLICATION


-- USERS TABLE
CREATE TABLE USERS (
    user_id        INT PRIMARY KEY,
    full_name      VARCHAR2(50),
    gender         VARCHAR2(10),
    age            INT,
    phone          VARCHAR2(15),
    email          VARCHAR2(50) UNIQUE,
    city           VARCHAR2(30),
    state          VARCHAR2(30)
);

-- PROFILE TABLE
CREATE TABLE PROFILE (
    profile_id     INT PRIMARY KEY,
    user_id        INT REFERENCES USERS(user_id),
    education      VARCHAR2(40),
    occupation     VARCHAR2(40),
    annual_income  NUMBER,
    height_cm      NUMBER,
    marital_status VARCHAR2(20)
);

-- PARTNER PREFERENCES TABLE
CREATE TABLE PARTNER_PREFERENCES (
    pref_id         INT PRIMARY KEY,
    user_id         INT REFERENCES USERS(user_id),
    min_age         INT,
    max_age         INT,
    preferred_city  VARCHAR2(30),
    preferred_education VARCHAR2(40)
);

-- MATCHES TABLE
CREATE TABLE MATCHES (
    match_id     INT PRIMARY KEY,
    user_id      INT REFERENCES USERS(user_id),
    matched_user INT REFERENCES USERS(user_id),
    match_date   DATE
);

 ======================================
-- SAMPLE DATA


INSERT INTO USERS VALUES 
(1, 'Kamal', 'Male', 21, '9392882454', 'kamal@gmail.com', 'Kavali', 'AP');

INSERT INTO USERS VALUES 
(2, 'Sree', 'Female', 20, '9990001112', 'sree@gmail.com', 'Nellore', 'AP');

INSERT INTO USERS VALUES 
(3, 'Arjun', 'Male', 25, '8887776665', 'arjun@gmail.com', 'Chennai', 'TN');

INSERT INTO PROFILE VALUES 
(101, 1, 'BTech', 'Engineer', 300000, 170, 'Single');

INSERT INTO PROFILE VALUES 
(102, 2, 'BSc', 'Teacher', 250000, 160, 'Single');

INSERT INTO PROFILE VALUES 
(103, 3, 'MCA', 'Developer', 400000, 175, 'Single');

INSERT INTO PARTNER_PREFERENCES VALUES 
(201, 1, 18, 25, 'AP', 'Any');

INSERT INTO PARTNER_PREFERENCES VALUES 
(202, 2, 20, 30, 'AP', 'Engineer');

 ======================================
-- MAIN QUERIES


-- View all profiles
SELECT * 
FROM USERS u
JOIN PROFILE p ON u.user_id = p.user_id;

-- Search by gender
SELECT full_name, age, city 
FROM USERS 
WHERE gender = 'Female';

-- Find matches for user_id = 1
SELECT u.full_name, u.age, u.city, p.education
FROM USERS u
JOIN PROFILE p ON u.user_id = p.user_id
JOIN PARTNER_PREFERENCES pr ON pr.user_id = 1
WHERE u.age BETWEEN pr.min_age AND pr.max_age
  AND (p.education = pr.preferred_education OR pr.preferred_education = 'Any');

-- Save match
INSERT INTO MATCHES VALUES (1, 1, 2, SYSDATE);

-- Update user city
UPDATE USERS
SET city = 'Hyderabad'
WHERE user_id = 1;

-- Delete a user
DELETE FROM USERS WHERE user_id = 3;
