-- Log in to MySQL as root
-- Create database
CREATE DATABASE IF NOT EXISTS hair_project_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- Create user
CREATE USER IF NOT EXISTS 'dev_admin'@'localhost' IDENTIFIED BY 'administrator';

-- Provide all permissions on the database for the user
GRANT ALL PRIVILEGES ON hair_project_db.* TO 'dev_admin'@'localhost' IDENTIFIED BY 'administrator';
FLUSH PRIVILEGES;

-- Log out then login with the admin user
-- mysql -u dev_admin -p

-- Select database
USE hair_project_db;

-- Create USERS table
-- InnoDB is the default MySQL storage engine
CREATE TABLE IF NOT EXISTS hair_project_db.users
(
    `id`            BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
    `user_name`     VARCHAR(32) NOT NULL,
    `user_password` VARCHAR(512) NOT NULL,
    `user_email`    VARCHAR(512) NOT NULL,
    `first_name`    VARCHAR(128) NOT NULL DEFAULT 'user',
    `last_name`     VARCHAR(128),
    `user_role`     ENUM('admin', 'developer', 'user') NOT NULL DEFAULT 'user',
    `date_created`  DATETIME NOT NULL DEFAULT NOW(),
    `date_modified` DATETIME DEFAULT NULL ON UPDATE NOW(),
    INDEX (`id`)
)
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci
ENGINE = INNODB;


-- USER_FEATURES table
CREATE TABLE IF NOT EXISTS hair_project_db.user_features
(
    `id`             BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
    `user_id`        BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `face_shape_id`  BIGINT NOT NULL,
    `skin_tone_id`   BIGINT NOT NULL,
    `hair_style_id`  BIGINT NOT NULL,
    `hair_length_id` BIGINT NOT NULL,
    `hair_colour_id` BIGINT NOT NULL,
    `date_created`   DATETIME NOT NULL DEFAULT NOW(),
    `date_modified`  DATETIME DEFAULT NULL ON UPDATE NOW(),
    INDEX (`id`),
    FOREIGN KEY (`user_id`)
        REFERENCES hair_project_db.users (`id`)
        ON DELETE CASCADE
)
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci
ENGINE = INNODB;

-- FACE_SHAPES table
CREATE TABLE IF NOT EXISTS hair_project_db.face_shapes
(
    `id`            BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
    `shape_name`    VARCHAR(128) NOT NULL DEFAULT '** ERROR: missing category **',
    `date_created`  DATETIME NOT NULL DEFAULT NOW(),
    `date_modified` DATETIME DEFAULT NULL ON UPDATE NOW(),
    INDEX (`id`)
)
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci
ENGINE = INNODB;

-- FACE_SHAPE_LINKS table
CREATE TABLE IF NOT EXISTS hair_project_db.face_shape_links
(
    `id`            BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
    `face_shape_id` BIGINT UNSIGNED NOT NULL,
    `link_name`     VARCHAR(128) NOT NULL DEFAULT '** ERROR: missing category **',
    `link_url`      VARCHAR(512) NOT NULL DEFAULT '** ERROR: missing category **',
    `date_created`  DATETIME NOT NULL DEFAULT NOW(),
    `date_modified` DATETIME DEFAULT NULL ON UPDATE NOW(),
    INDEX(`id`),
    FOREIGN KEY (`face_shape_id`)
        REFERENCES hair_project_db.face_shapes (`id`)
        ON DELETE CASCADE
)
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci
ENGINE = INNODB;

-- HAIR_STYLES table
CREATE TABLE IF NOT EXISTS hair_project_db.hair_styles
(
    `id`              BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
    `hair_style_name` VARCHAR(128) NOT NULL DEFAULT '** ERROR: missing category **',
    `date_created`    DATETIME NOT NULL DEFAULT NOW(),
    `date_modified`   DATETIME DEFAULT NULL ON UPDATE NOW(),
    INDEX (`id`)
)
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci
ENGINE = INNODB;

-- HAIR_STYLE_LINKS table
CREATE TABLE IF NOT EXISTS hair_project_db.hair_style_links
(
    `id`            BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
    `hair_style_id` BIGINT UNSIGNED NOT NULL,
    `link_name`     VARCHAR(128) NOT NULL DEFAULT '** ERROR: missing category **',
    `link_url`      VARCHAR(512) NOT NULL DEFAULT '** ERROR: missing category **',
    `date_created`  DATETIME NOT NULL DEFAULT NOW(),
    `date_modified` DATETIME DEFAULT NULL ON UPDATE NOW(),
    INDEX(`id`),
    FOREIGN KEY (`hair_style_id`)
        REFERENCES hair_project_db.hair_styles (`id`)
        ON DELETE CASCADE
)
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci
ENGINE = INNODB;

-- HAIR_LENGTHS table
CREATE TABLE IF NOT EXISTS hair_project_db.hair_lengths
(
    `id`               BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
    `hair_length_name` VARCHAR(128) NOT NULL DEFAULT '** ERROR: missing category **',
    `date_created`     DATETIME NOT NULL DEFAULT NOW(),
    `date_modified`    DATETIME DEFAULT NULL ON UPDATE NOW(),
    INDEX (`id`)
)
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci
ENGINE = INNODB;

-- HAIR_LENGTH_LINKS table
CREATE TABLE IF NOT EXISTS hair_project_db.hair_length_links
(
    `id`             BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
    `hair_length_id` BIGINT UNSIGNED NOT NULL,
    `link_name`      VARCHAR(128) NOT NULL DEFAULT '** ERROR: missing category **',
    `link_url`       VARCHAR(512) NOT NULL DEFAULT '** ERROR: missing category **',
    `date_created`   DATETIME NOT NULL DEFAULT NOW(),
    `date_modified`  DATETIME DEFAULT NULL ON UPDATE NOW(),
    INDEX(`id`),
    FOREIGN KEY (`hair_length_id`)
        REFERENCES hair_project_db.hair_lengths (`id`)
        ON DELETE CASCADE
)
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci
ENGINE = INNODB;

-- SKIN_TONES table
CREATE TABLE IF NOT EXISTS hair_project_db.skin_tones
(
    `id`             BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
    `skin_tone_name` VARCHAR(128) NOT NULL DEFAULT '** ERROR: missing category **',
    `date_created`   DATETIME NOT NULL DEFAULT NOW(),
    `date_modified`  DATETIME DEFAULT NULL ON UPDATE NOW(),
    INDEX (`id`)
)
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci
ENGINE = INNODB;

-- SKIN_TONE_LINKS table
CREATE TABLE IF NOT EXISTS hair_project_db.skis_tone_links
(
    `id`            BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
    `skin_tone_id`  BIGINT UNSIGNED NOT NULL,
    `link_name`     VARCHAR(128) NOT NULL DEFAULT '** ERROR: missing category **',
    `link_url`      VARCHAR(512) NOT NULL DEFAULT '** ERROR: missing category **',
    `date_created`  DATETIME NOT NULL DEFAULT NOW(),
    `date_modified` DATETIME DEFAULT NULL ON UPDATE NOW(),
    INDEX(`id`),
    FOREIGN KEY (`skin_tone_id`)
        REFERENCES hair_project_db.skin_tones (`id`)
        ON DELETE CASCADE
)
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci
ENGINE = INNODB;

-- COLOURS table
CREATE TABLE IF NOT EXISTS hair_project_db.colours
(
    `id`            BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
    `colour_name`   VARCHAR(64) NOT NULL DEFAULT '** ERROR: missing category **',
    `colour_hash`   VARCHAR(64) NOT NULL DEFAULT '** ERROR: missing category **',
    `date_created`  DATETIME NOT NULL DEFAULT NOW(),
    `date_modified` DATETIME DEFAULT NULL ON UPDATE NOW(),
    INDEX(`id`)
)
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci
ENGINE = INNODB;



INSERT INTO hair_project_db.colours(`id`, `colour_name`, `colour_hash`)
VALUES 
(1, 'very_light_blonde','#'),
(2, 'light_blonde', '#'),
(3, 'medium_blonde', '#'),
(4, 'dark_blond', '#'),
(5, 'light_brown', '#'),
(6, 'medium_brown', '#'),
(7, 'dark_brown', '#'),
(8, 'black/brown', '#'), 
(9, 'dark_black/brown', '#'),
(10, 'black', '#');

INSERT INTO hair_project_db.face_shapes(`id`,`shape_name`,)
VALUES
(1, 'heart'), 
(2, 'square'), 
(3,'rectangular'), 
(4, 'diamond'),
(5, 'triangular'),
(6, 'inverted_triangular');

INSERT INTO  hair_project_db.skin_tones(`id`, `skin_tone_name`)
VALUES
(1, 'fair'),
(2, 'olive'),
(3, 'light_brown'),
(4, 'brown'),
(5, 'dark_brown'),
(6, 'black_brown');

INSERT INTO  hair_project_db.hair_lengths(`id`, `hair_length_id`, `link_name`, `link_url`)
VALUES 
(1, 'forme_massive'),
(2, 'forme_degradee'),
(3, 'forme_progressive'),
(4, 'forme_uniforne');





-- TODO
-- just waiting for URL's to insert then can upload rest if seeded tables
