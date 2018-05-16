--*** Population ***

\cd "/mnt/e/ENS\ Paris-Saclay/Cours/Bdd"

\copy user_category FROM categories2.csv csv NULL 'not_found';

\copy user_city FROM cities2.csv csv NULL 'not_found';

\copy user_member(member_id,bio,city_name,joined,member_name,member_status,visited,group_id) 
FROM members2.csv csv HEADER NULL 'not_found';

\copy user_groups
FROM groups2.csv csv HEADER NULL 'not_found';

\copy user_topic 
FROM topics2.csv csv NULL 'not_found';

\copy user_grouptopic(topic_id,group_id)
FROM groups_topics2.csv csv NULL 'not_found';

\copy user_events(event_id,created,description,duration,fee_accepts,fee_amount,fee_required,headcount,
how_to_find_us,maybe_rsvp_count,event_name,photo_url,rating_average,rating_count,
rsvp_limit,event_status,event_time,updated,venue_id,repinned,visibility,waitlist_count,
why,yes_rsvp_count, group_id) FROM events2.csv csv HEADER NULL 'not_found';

\copy user_venue(venue_id,address_1,city_name,venue_name,rating_average,rating_count) FROM venues2.csv csv NULL 'not_found';

\copy user_topicfollowed(topic_id,member_id) FROM members_topics2.csv csv NULL 'not_found';

\copy user_websitemanager(user_id,user_name,joined,manager_type) FROM websitemanager2.csv csv HEADER NULL 'not_found';

\copy user_moderatorcategory(user_id,category_id) FROM moderator_categories2.csv csv HEADER NULL 'not_found';

--*** Indices ***

CREATE INDEX user_member_member_id ON public.user_member USING btree (member_id) TABLESPACE pg_default;

CREATE INDEX user_member_member_name ON public.user_member USING btree (member_name) TABLESPACE pg_default;

CREATE INDEX user_member_group_id ON public.user_member
USING btree (group_id) TABLESPACE pg_default;

CREATE INDEX user_member_city_name ON public.user_member
USING btree (city_name) TABLESPACE pg_default;

CREATE INDEX user_venue_city_name2 ON public.user_venue
USING btree (city_name) TABLESPACE pg_default;

CREATE INDEX user_venue_rating_average ON public.user_venue
USING btree (rating_average) TABLESPACE pg_default;

CREATE INDEX user_event_rating_average ON public.user_events
USING btree (rating_average) TABLESPACE pg_default;

