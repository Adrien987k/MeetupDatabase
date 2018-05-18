
COPY user_category
FROM categories2.csv csv NULL 'not_found';

COPY user_city
FROM cities2.csv csv NULL 'not_found';

COPY user_member(member_id,bio,city_name,joined,member_name,member_status,visited,group_id)
FROM members2.csv csv HEADER NULL 'not_found';

COPY user_groups
FROM groups2.csv csv HEADER NULL 'not_found';

COPY user_topic
FROM topics2.csv csv NULL 'not_found';

COPY user_grouptopic(topic_id, group_id)
FROM groups_topics2.csv csv NULL 'not_found';

COPY user_events(event_id,created,description,duration,fee_accepts,fee_amount,fee_required,headcount,
				 how_to_find_us,maybe_rsvp_count,event_name,photo_url,rating_average,rating_count,
				 rsvp_limit,event_status,event_time,updated,repinned,visibility,waitlist_count,
				 why,yes_rsvp_count, group_id,venue_id) 
FROM events2.csv csv HEADER NULL 'not_found';

copy user_venue
FROM venues2.csv csv NULL 'not_found';

COPY user_topicfollowed(member_id, topic_id)
FROM members_topics2.csv csv NULL 'not_found';

COPY user_websitemanager
FROM websitemanager2.csv csv HEADER NULL 'not_found';

COPY user_moderatorcategory(category_id, user_id)
FROM moderator_categories2.csv csv HEADER NULL 'not_found';
