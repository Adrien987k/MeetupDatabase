\copy Category(category_id,category_name,shortname) FROM categories2.csv csv NULL 'not_found';

\copy City(city_name,city_id,country,latitude,longitude,state) FROM cities2.csv csv NULL 'not_found';

\copy Member(member_id,bio,city_name,joined,member_name,member_status,visited,group_id) FROM members2.csv csv HEADER NULL 'not_found';

\copy Groups(group_id,category_id,city_name,created,description,photo_photo_link,join_mode,group_name,organizer_id,visibility,who) FROM groups2.csv csv HEADER NULL 'not_found';

\copy Topic(topic_id,description,topic_name,urlkey,parent_topic_id) FROM topics2.csv csv NULL 'not_found';

\copy Group_topic(topic_id,group_id) FROM groups_topics2.csv csv NULL 'not_found';

\copy Event(event_id,created,description,duration,fee_accepts,fee_amount,fee_required,group_id,headcount,how_to_find_us,maybe_rsvp_count,event_name,photo_url,rating_average,rating_count,rsvp_limit,event_status,event_time,updated,venue_id,repinned,visibility,waitlist_count,why,yes_rsvp_count) FROM events2.csv csv HEADER NULL 'not_found';

\copy Venue(venue_id,address_1,city_name,venue_name,rating_average,rating_count) FROM venues2.csv csv NULL 'not_found';

\copy Topic_followed(topic_id,member_id) FROM members_topics2.csv csv NULL 'not_found';

\copy Websitemanager(user_id,user_name,joined,manager_type) FROM websitemanager2.csv csv HEADER NULL 'not_found';

\copy Moderator_category(user_id,category_id) FROM moderator_categories2.csv csv HEADER NULL 'not_found';

