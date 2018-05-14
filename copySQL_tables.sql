COPY user_category(category_id,category_name,shortname)
FROM 'G:/ENS Paris-Saclay/Cours/Bdd/MeetupDatabase/categories2.csv' csv NULL 'not_found';

COPY user_city
FROM 'G:/ENS Paris-Saclay/Cours/Bdd/MeetupDatabase/cities2.csv' csv NULL 'not_found';

copy user_member(member_id,bio,city_name,joined,member_name,member_status,visited,group_id)
FROM 'G:/ENS Paris-Saclay/Cours/Bdd/MeetupDatabase/members2.csv' csv HEADER NULL 'not_found';

copy user_groups
FROM 'G:/ENS Paris-Saclay/Cours/Bdd/MeetupDatabase/groups2.csv' csv HEADER NULL 'not_found';

copy user_topic
FROM 'G:/ENS Paris-Saclay/Cours/Bdd/MeetupDatabase/topics2.csv' csv NULL 'not_found';

-- copy user_grouptopic(topic_id, group_id)
-- FROM 'G:/ENS Paris-Saclay/Cours/Bdd/MeetupDatabase/groups_topics2.csv' csv NULL 'not_found';

copy user_events(event_id,created,description,duration,fee_accepts,fee_amount,fee_required,headcount,how_to_find_us,maybe_rsvp_count,event_name,photo_url,rating_average,rating_count,rsvp_limit,event_status,event_time,updated,repinned,visibility,waitlist_count,why,yes_rsvp_count, group_id,venue_id) 
FROM 'G:/ENS Paris-Saclay/Cours/Bdd/MeetupDatabase/events2.csv' csv HEADER NULL 'not_found';

copy user_venue
FROM 'G:/ENS Paris-Saclay/Cours/Bdd/MeetupDatabase/venues2.csv' csv NULL 'not_found';

-- copy user_topicfollowed(member_id, topic_id)
-- FROM 'G:/ENS Paris-Saclay/Cours/Bdd/MeetupDatabase/members_topics2.csv' csv NULL 'not_found';

copy user_websitemanager
FROM 'G:/ENS Paris-Saclay/Cours/Bdd/MeetupDatabase/websitemanager2.csv' csv HEADER NULL 'not_found';

-- copy user_moderatorcategory(category_id, user_id_id)
-- FROM 'G:/ENS Paris-Saclay/Cours/Bdd/MeetupDatabase/moderator_categories2.csv' csv HEADER NULL 'not_found';
