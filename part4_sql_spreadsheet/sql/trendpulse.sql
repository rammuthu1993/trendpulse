-- ==========================================
-- TRENDPULSE DATABASE
-- ==========================================

DROP DATABASE IF EXISTS trendpulse_db;

CREATE DATABASE trendpulse_db;

USE trendpulse_db;


-- ==========================================
-- 1. CATEGORIES TABLE
-- ==========================================

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(150) NOT NULL
);


-- ==========================================
-- 2. VIDEOS TABLE
-- ==========================================

CREATE TABLE videos (
    video_id VARCHAR(50) PRIMARY KEY,
    title TEXT,
    channel_title VARCHAR(255),
    category_id INT,
    publish_time DATETIME,

    CONSTRAINT fk_videos_categories
        FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
);


-- ==========================================
-- 3. TRENDING RECORDS TABLE
-- ==========================================

CREATE TABLE trending_records (
    record_id BIGINT AUTO_INCREMENT PRIMARY KEY,

    video_id VARCHAR(50) NOT NULL,
    country VARCHAR(10) NOT NULL,
    trending_date DATE NOT NULL,

    views BIGINT NOT NULL,
    likes BIGINT NOT NULL,
    dislikes BIGINT NOT NULL,
    comment_count BIGINT NOT NULL,

    CONSTRAINT fk_trending_videos
        FOREIGN KEY (video_id)
        REFERENCES videos(video_id),

    CONSTRAINT uq_video_country_date
        UNIQUE (video_id, country, trending_date)
);


-- ==========================================
-- INDEXES
-- ==========================================

CREATE INDEX idx_trending_country
ON trending_records(country);

CREATE INDEX idx_trending_date
ON trending_records(trending_date);

CREATE INDEX idx_trending_views
ON trending_records(views);

CREATE INDEX idx_videos_category
ON videos(category_id);


-- USE trendpulse_db;

-- SHOW TABLES;

-- DESCRIBE categories;

-- DESCRIBE videos;

-- DESCRIBE trending_records;