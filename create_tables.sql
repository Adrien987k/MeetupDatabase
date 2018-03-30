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
       country VARCHAR(50) NOT NULL,
       latitude REAL NOT NULL,
       longitude REAL NOT NULL,
       state VARCHAR(50));

CREATE TYPE USER_STATUS_TYPE AS ENUM ('active');
CREATE TABLE Member(
       user_id INTEGER PRIMARY KEY,
       user_name VARCHAR(50) NOT NULL,
       user_status USER_STATUS_TYPE NOT NULL,
       joined DATE NOT NULL,
       bio TEXT,
       city_id INTEGER
       FOREIGN KEY city_id REFERENCES City(city_id)
               ON DELETE SET NULL,
       visited DATE NOT NULL,
       photo.base_url TEXT,
       photo.highres_url TEXT,
       photo.photo_link TEXT,
       photo.thumb_link TEXT,
       photo.type VARCHAR(20));

CREATE TABLE Moderator_category(
       user_id INTEGER
       FOREIGN KEY user_id REFERENCES Member(user_id)
               ON DELETE CASCADE,
       category_id INTEGER,
       FOREIGN KEY category_id REFERENCES Category(category_id)
               ON DELETE CASCADE);

CREATE TABLE Group_organizer(
       group_id INTEGER,
       FOREIGN KEY group_id REFERENCES Group(group_id)
               ON DELETE CASCADE,
       user_id INTEGER,
       FOREIGN KEY user_id REFERENCES Member(user_id)
               ON DELETE CASCADE);

CREATE TABLE Group_follower(
       group_id INTEGER,
       FOREIGN KEY group_id REFERENCES Group(group_id)
               ON DELETE CASCADE,
       user_id INTEGER,
       FOREIGN KEY user_id REFERENCES Member(user_id)
               ON DELETE CASCADE);


CREATE TABLE Topic(
       topic_id INTEGER PRIMARY KEY,
       description TEXT,
       urlkey VARCHAR(20) NOT NULL,
       topic_name VARCHAR(50) NOT NULL,
       parent_topic_id INTEGER);

CREATE TYPE ACCEPTS_TYPE AS ENUM ('cash', 'paypal', 'wepal', 'amazon', 'others');

CREATE TABLE Fee(
       fee_id INTEGER PRIMARY KEY,
       accpets ACCEPTS_TYPE NOT NULL,
       amount REAL,
       currency VARCHAR(20),
       description TEXT,
       required BOOLEAN NOT NULL);

CREATE TABLE Venue(
       venue_id INTEGER PRIMARY KEY,
       address_1 VARCHAR(50) NOT NULL,
       venue_name VARCHAR(50) NOT NULL,
       city_id INTEGER,
       FOREIGN KEY city_id REFERENCES City(city_id)
               ON DELETE CASCADE
       rating.average REAL NOT NULL,
       rating.count INTEGER NOT NULL);


CREATE TYPE EVENT_STATUS_TYPE AS ENUM('cancelled', 'upcoming', 'past', 'proposed');
CREATE TYPE VISIBILITY_TYPE AS ENUM('public', 'member', 'public_limited');

CREATE TABLE Event(
       event_id INTEGER PRIMARY KEY,
       group_id INTEGER,
       FOREIGN KEY group_id REFERENCES Group(group_id)
               ON DELETE CASCADE,
       created DATE NOT NULL,
       description TEXT,
       duration INTEGER NOT NULL,
       photo_url TEXT,
       how_to_find_us TEXT,
       event_name VARCHAR(50) NOT NULL,
       event_status EVENT_STATUS_TYPE NOT NULL,
       event_time DATE NOT NULL,
       fee_id INTEGER,
       FOREIGN KEY fee_id REFERENCES Fee(fee_id)
               ON DELETE SET NULL,
       venue_id INTEGER,
       FOREIGN KEY venue_id REFERENCES Venue(venue_id)
               ON DELETE CASCADE,
       updated DATE,
       visibility VISIBILITY_TYPE NOT NULL,
       why TEXT,
       headcount INTEGER,
       rating_average REAL,
       raiting.count INTEGER NOT NULL,
       rsvp_limit INTEGER NOT NULL,
       maybe_rsvp_count INTEGER NOT NULL,
       yes_rsvp_count INTEGER NOT NULL);

CREATE TABLE Event_organizer(
       event_id INTEGER,
       FOREIGN KEY event_id REFERENCES Event(event_id)
                  ON DELETE CASCADE,
       user_id INTEGER,
       FOREIGN KEY user_id  REFERENCES Member(user_id)
                  ON DELETE CASCADE);

CREATE TYPE JOIN_MODE_TYPE AS ENUM('open', 'closed', 'approval');

CREATE TABLE Group(
       group_id INTEGER PRIMARY KEY,
       created DATE NOT NULL,
       category_id INTEGER,
       FOREIGN KEY category_id REFERENCES Category(category_id)
               ON DELETE CASCADE
       description TEXT NOT NULL,
       join_mode JOIN_MODE_TYPE NOT NULL,
       group_name VARCHAR(50),
       city_id INTEGER,
       FOREIGN KEY city_id REFERENCES City(city_id)
               ON DELETE SET NULL,
       visibility VISIBILITY_TYPE NOT NULL,
       who VARCHAR(50),
       photo.base_url TEXT,
       photo.highres_link TEXT,
       photo.photo_link TEXT,
       photo.thumb_link TEXT,
       photo.type VARCHAR(20));
