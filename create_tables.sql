
CREATE TYPE MANAGER_TYPE_TYPE AS ENUM ('Moderator', 'Administrator');
CREATE TYPE EVENT_STATUS_TYPE AS ENUM('cancelled', 'upcoming', 'past', 'proposed');
CREATE TYPE VISIBILITY_TYPE AS ENUM('public', 'member', 'public_limited');
CREATE TYPE ACCEPTS_TYPE AS ENUM ('cash', 'paypal', 'wepal', 'amazon', 'others');
CREATE TYPE USER_STATUS_TYPE AS ENUM ('active');
CREATE TYPE JOIN_MODE_TYPE AS ENUM('open', 'closed', 'approval');


CREATE TABLE WebsiteManager(
       user_id INTEGER PRIMARY KEY,
       user_name VARCHAR(50) NOT NULL,
       joined TIMESTAMP NOT NULL,
       manager_type MANAGER_TYPE_TYPE NOT NULL
);

CREATE TABLE Category(
       category_id INTEGER PRIMARY KEY,
       category_name VARCHAR(50) NOT NULL,
       shortname VARCHAR(20) NOT NULL
);

CREATE TABLE City(
       city_id INTEGER PRIMARY KEY,
       city_name VARCHAR(50) PRIMARY KEY,
       country VARCHAR(50) NOT NULL,
       latitude REAL NOT NULL,
       longitude REAL NOT NULL,
       state VARCHAR(50)
);

CREATE TABLE Groups(
       group_id INTEGER PRIMARY KEY,
       created TIMESTAMP NOT NULL,
       category_id INTEGER REFERENCES Category(category_id) ON DELETE CASCADE,
       description TEXT NOT NULL,
       join_mode JOIN_MODE_TYPE NOT NULL,
       organizer INTEGER,
       group_name VARCHAR(50),
       city_id INTEGER REFERENCES City(city_id) ON DELETE SET NULL,
       visibility VISIBILITY_TYPE NOT NULL,
       who VARCHAR(50),
       photo_photo_link VARCHAR(200)
);

CREATE TABLE Member(
       member_id INTEGER PRIMARY KEY,
       member_name VARCHAR(50) NOT NULL,
       member_status USER_STATUS_TYPE NOT NULL,
       joined TIMESTAMP NOT NULL,
       bio TEXT,
       city_name VARCHAR(50) REFERENCES City(city_name) ON DELETE SET NULL,
       visited TIMESTAMP NOT NULL
);

CREATE TABLE Moderator_category(
       user_id INTEGER REFERENCES Member(member_id) ON DELETE CASCADE,
       category_id INTEGER REFERENCES Category(category_id) ON DELETE CASCADE
);

CREATE TABLE Group_followed(
       group_id INTEGER REFERENCES Groups(group_id) ON DELETE CASCADE,
       user_id INTEGER REFERENCES Member(member_id) ON DELETE CASCADE
);


CREATE TABLE Topic(
       topic_id INTEGER PRIMARY KEY,
       description TEXT,
       urlkey VARCHAR(20) NOT NULL,
       topic_name VARCHAR(50) NOT NULL,
       parent_topic_id INTEGER
);

CREATE TABLE Venue(
       venue_id INTEGER PRIMARY KEY,
       address_1 VARCHAR(50) NOT NULL,
       venue_name VARCHAR(50) NOT NULL,
       city_name VARCHAR(50) REFERENCES City(city_name) ON DELETE CASCADE
       rating_average REAL NOT NULL,
       rating_count INTEGER NOT NULL);

CREATE TABLE Event(
       event_id INTEGER PRIMARY KEY,
       group_id INTEGER REFERENCES Groups(group_id) ON DELETE CASCADE,
       created TIMESTAMP NOT NULL,
       description TEXT,
       duration INTEGER NOT NULL,
       photo_url TEXT,
       how_to_find_us TEXT,
       event_name VARCHAR(50) NOT NULL,
       event_status EVENT_STATUS_TYPE NOT NULL,
       event_time TIMESTAMP NOT NULL,
       venue_id INTEGER REFERENCES Venue(venue_id) ON DELETE CASCADE,
       updated TIMESTAMP,
       visibility VISIBILITY_TYPE NOT NULL,
       why TEXT,
       headcount INTEGER,
       rating_average REAL,
       raiting_count INTEGER NOT NULL,
       rsvp_limit INTEGER NOT NULL,
       maybe_rsvp_count INTEGER NOT NULL,
       yes_rsvp_count INTEGER NOT NULL,
       fee_accpets ACCEPTS_TYPE NOT NULL,
       fee_amount REAL,
       fee_required BOOLEAN NOT NULL,
       repinned BOOLEAN);

CREATE TABLE Topic_followed(
       topic_id INTEGER REFERENCES Topic(topic_id) ON DELETE CASCADE,
       member_id INTEGER REFERENCES Member(memebr_id) ON DELETE CASCADE);
