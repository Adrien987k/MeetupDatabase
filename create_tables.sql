
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
       city_id INTEGER FOREIGN KEY REFERENCES City(city_id),
       rating.average REAL NOT NULL,
       rating.count INTEGER NOT NULL);

CREATE TYPE EVENT_STATUS_TYPE AS ENUM('cancelled', 'upcoming', 'past', 'proposed')
CREARE TYPE VISIBILITY_TYPE AS ENUM('public', 'member', 'public_limited')


CREATE TABLE Event(
       event_id INTEGER PRIMARY KEY,
       group_id INTEGER FOREIGN KEY REFERENCES Group(group_id),
       created DATE NOT NULL,
       description TEXT,
       duration INTEGER NOT NULL,
       photo_url TEXT,
       how_to_find_us TEXT,
       event_name VARCHAR(50) NOT NULL,
       event_status EVENT_STATUS_TYPE NOT NULL,
       event_time DATE NOT NULL,
       fee_id INTEGER FOREIGN KEY REFERENCES Fee(fee_id),
       venue_id INTEGER FOREIGN KEY REFERENCES Venue(venue_id),
       updated DATE,
       visibility VISIBILITY_TYPE
       ...);
