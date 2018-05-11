BEGIN;
--
-- Create model Category
--
CREATE TABLE "user_category" ("category_id" integer NOT NULL PRIMARY KEY, "category_name" varchar(50) NOT NULL, "shortname" varchar(20) NOT NULL);
--
-- Create model City
--
CREATE TABLE "user_city" ("city_id" integer NOT NULL, "city_name" varchar(50) NOT NULL PRIMARY KEY, "country" varchar(50) NOT NULL, "latitude" double precision NOT NULL, "longitude" double precision NOT NULL, "state" varchar(50) NULL);
--
-- Create model Events
--
CREATE TABLE "user_events" ("event_id" varchar(20) NOT NULL PRIMARY KEY, "created" timestamp with time zone NOT NULL, "description" text NULL, "duration" integer NOT NULL, "photo_url" text NULL, "how_to_find_us" text NULL, "event_name" varchar(100) NOT NULL, "event_status" text NOT NULL, "event_time" timestamp with time zone NOT NULL, "updated" timestamp with time zone NULL, "visibility" text NOT NULL, "why" text NULL, "headcount" integer NULL, "rating_average" double precision NULL, "rating_count" integer NOT NULL, "rsvp_limit" integer NOT NULL, "maybe_rsvp_count" integer NOT NULL, "yes_rsvp_count" integer NOT NULL, "waitlist_count" integer NOT NULL, "fee_accepts" text NOT NULL, "fee_amount" double precision NULL, "fee_required" boolean NOT NULL, "repinned" boolean NULL);
--
-- Create model Groups
--
CREATE TABLE "user_groups" ("group_id" integer NOT NULL PRIMARY KEY, "created" timestamp with time zone NOT NULL, "description" text NOT NULL, "join_mode" text NOT NULL, "organizer_id" integer NULL, "group_name" varchar(100) NULL, "visibility" text NOT NULL, "who" varchar(50) NULL, "photo_photo_link" varchar(200) NULL, "category_id" integer NULL, "city_name" varchar(50) NULL);
--
-- Create model GroupTopic
--
CREATE TABLE "user_grouptopic" ("id" serial NOT NULL PRIMARY KEY, "group_id" integer NULL);
--
-- Create model Member
--
CREATE TABLE "user_member" ("member_group_id" integer NOT NULL PRIMARY KEY, "member_id" integer NULL, "group_id" integer NULL, "member_name" varchar(50) NOT NULL, "member_status" text NOT NULL, "joined" timestamp with time zone NOT NULL, "bio" text NULL, "city_name" varchar(50) NULL, "visited" timestamp with time zone NOT NULL);
--
-- Create model ModeratorCategory
--
CREATE TABLE "user_moderatorcategory" ("id" serial NOT NULL PRIMARY KEY, "category_id" integer NULL, "user_id" integer NULL);
--
-- Create model Topic
--
CREATE TABLE "user_topic" ("topic_id" integer NOT NULL PRIMARY KEY, "description" text NULL, "urlkey" varchar(50) NOT NULL, "topic_name" varchar(50) NOT NULL, "parent_topic_id" integer NULL);
--
-- Create model TopicFollowed
--
CREATE TABLE "user_topicfollowed" ("id" serial NOT NULL PRIMARY KEY, "member_id" integer NULL, "topic_id" integer NULL);
--
-- Create model Venue
--
CREATE TABLE "user_venue" ("venue_id" integer NOT NULL PRIMARY KEY, "address_1" varchar(200) NULL, "venue_name" varchar(200) NULL, "city_name" varchar(50) NULL, "rating_average" double precision NOT NULL, "rating_count" double precision NOT NULL);
--
-- Create model Websitemanager
--
CREATE TABLE "user_websitemanager" ("user_id" integer NOT NULL PRIMARY KEY, "user_name" varchar(50) NOT NULL, "joined" timestamp with time zone NOT NULL, "manager_type" text NOT NULL);
--
-- Add field topic to grouptopic
--
ALTER TABLE "user_grouptopic" ADD COLUMN "topic_id" integer NULL;
--
-- Add field group to events
--
ALTER TABLE "user_events" ADD COLUMN "group_id" integer NULL;
--
-- Add field venue to events
--
ALTER TABLE "user_events" ADD COLUMN "venue_id" integer NULL;
CREATE INDEX "user_city_city_name_4abc6f40_like" ON "user_city" ("city_name" varchar_pattern_ops);
CREATE INDEX "user_events_event_id_921e20f6_like" ON "user_events" ("event_id" varchar_pattern_ops);
ALTER TABLE "user_groups" ADD CONSTRAINT "user_groups_category_id_f9df26c6_fk_user_category_category_id" FOREIGN KEY ("category_id") REFERENCES "user_category" ("category_id") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "user_groups" ADD CONSTRAINT "user_groups_city_name_f57218d6_fk_user_city_city_name" FOREIGN KEY ("city_name") REFERENCES "user_city" ("city_name") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "user_groups_category_id_f9df26c6" ON "user_groups" ("category_id");
CREATE INDEX "user_groups_city_name_f57218d6" ON "user_groups" ("city_name");
CREATE INDEX "user_groups_city_name_f57218d6_like" ON "user_groups" ("city_name" varchar_pattern_ops);
ALTER TABLE "user_grouptopic" ADD CONSTRAINT "user_grouptopic_group_id_3ebd5a95_fk_user_groups_group_id" FOREIGN KEY ("group_id") REFERENCES "user_groups" ("group_id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "user_grouptopic_group_id_3ebd5a95" ON "user_grouptopic" ("group_id");
ALTER TABLE "user_moderatorcategory" ADD CONSTRAINT "user_moderatorcatego_category_id_3ed494fa_fk_user_cate" FOREIGN KEY ("category_id") REFERENCES "user_category" ("category_id") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "user_moderatorcategory" ADD CONSTRAINT "user_moderatorcatego_user_id_bc4e375f_fk_user_memb" FOREIGN KEY ("user_id") REFERENCES "user_member" ("member_group_id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "user_moderatorcategory_category_id_3ed494fa" ON "user_moderatorcategory" ("category_id");
CREATE INDEX "user_moderatorcategory_user_id_bc4e375f" ON "user_moderatorcategory" ("user_id");
ALTER TABLE "user_topicfollowed" ADD CONSTRAINT "user_topicfollowed_member_id_d94e5831_fk_user_memb" FOREIGN KEY ("member_id") REFERENCES "user_member" ("member_group_id") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "user_topicfollowed" ADD CONSTRAINT "user_topicfollowed_topic_id_9f56a0f0_fk_user_topic_topic_id" FOREIGN KEY ("topic_id") REFERENCES "user_topic" ("topic_id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "user_topicfollowed_member_id_d94e5831" ON "user_topicfollowed" ("member_id");
CREATE INDEX "user_topicfollowed_topic_id_9f56a0f0" ON "user_topicfollowed" ("topic_id");
CREATE INDEX "user_grouptopic_topic_id_97ee73d1" ON "user_grouptopic" ("topic_id");
ALTER TABLE "user_grouptopic" ADD CONSTRAINT "user_grouptopic_topic_id_97ee73d1_fk_user_topic_topic_id" FOREIGN KEY ("topic_id") REFERENCES "user_topic" ("topic_id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "user_events_group_id_950809ed" ON "user_events" ("group_id");
ALTER TABLE "user_events" ADD CONSTRAINT "user_events_group_id_950809ed_fk_user_groups_group_id" FOREIGN KEY ("group_id") REFERENCES "user_groups" ("group_id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "user_events_venue_id_4d3bd0d0" ON "user_events" ("venue_id");
ALTER TABLE "user_events" ADD CONSTRAINT "user_events_venue_id_4d3bd0d0_fk_user_venue_venue_id" FOREIGN KEY ("venue_id") REFERENCES "user_venue" ("venue_id") DEFERRABLE INITIALLY DEFERRED;
COMMIT;
