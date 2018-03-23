CREATE TYPE MANAGER_TYPE_TYPE AS ENUM ('Moderator', 'Administrator');
CREATE TABLE WebsiteManager(
       user_id INTEGER PRIMARY KEY,
       user_name VARCHAR(50) NOT NULL,
       joined DATE NOT NULL,
       manager_type MANAGER_TYPE_TYPE NOT NULL);

CREATE TABLE Category(
       category_id INTEGER PRIMARY KEY,
       category_name VARCHAR(50) NOT NULL,
       shortname VARCHAR(20) NOT NULL);

CREATE TABLE City(
       city_id INTEGER PRIMARY KEY,
       city_name VARCHAR(50) NOT NULL,
       country VARCHAR(50) NO NULL,
       latitude REAL NOT NULL,
       longitude REAL NOT NULL,
       state VARCHAR(50));

CREATE TYPE USER_STATUS_TYPE AS ENUM ('active')
CREATE TABLE Member(
       user_id INTEGER PRIMARY KEY,
       user_name VARCHAR(50) NOT NULL,
       user_status USER_STATUS_TYPE NOT NULL,
       joined DATE NOT NULL,
       bio TEXT,
       city_id INTEGER,
       FOREIGN KEY city_id REFERENCES City(city_id)
               ON DELETE SET NULL,
       visited DATE NOT NULL,
       photo.base_url TEXT,
       photo.highres_url TEXT,
       photo.photo_link TEXT,
       photo.thumb_link TEXT,
       photo.type VARCHAR(20));

CREATE TABLE Moderator_category(
       user_id INTEGER,
       FOREIGN KEY user_id REFERENCES Member(user_id)
               ON DELETE CASCADE,
       category_id INTEGER,
       FOREIGN KEY REFERENCES Category(category_id)
               ON DELETE CASCADE,);

CREATE TABLE Group_organizer(
       group_id INTEGER,
       FOREIGN KEY REFERENCES Group(group_id)
               ON DELETE CASCADE,
       user_id INTEGER,
       FOREIGN KEY REFERENCES Member(user_id)
               ON DELETE CASCADE);

CREATE TABLE Group_follower(
       group_id INTEGER,
       FOREIGN KEY REFERENCES Group(group_id)
               ON DELETE CASCADE,
       user_id INTEGER,
       FOREIGN KEY REFERENCES Member(user_id)
               ON DELETE CASCADE);
