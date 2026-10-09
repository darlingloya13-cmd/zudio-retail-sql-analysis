-- Create Database
CREATE DATABASE IF NOT EXISTS zudio_retail_db;
USE zudio_retail_db;

-- Drop table if it already exists
DROP TABLE IF EXISTS zudio_stores;

CREATE TABLE zudio_stores (
    store_id INT PRIMARY KEY AUTO_INCREMENT,
    state VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    estimated_population INT,
    per_capita_income INT,
    malls INT,
    buyers_count FLOAT,
    potential_location FLOAT,
    norm_potential FLOAT,
    norm_stores FLOAT,
    priority_index FLOAT
);
