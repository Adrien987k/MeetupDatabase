\copy Category(category_id,category_name,shortname)
FROM categories.csv csv HEADER NULL 'not_found';

\copy City(city_name,city_id,country,latitude,longitude,state)
FROM cities.csv csv HEADER NULL 'not_found';

\copy Member(member_id,bio,city_name,joined,member_name,member_status,visited)
FROM members.csv csv HEADER NULL 'not_found';

\copy Group(group_id,category_id,city_id,created,description,photo.photo_link,join_mode,group_name,organizer_id,visibility,who)
FROM groups.csv csv HEADER NULL 'not_found';

\copy Topic(topic_id,description,topic_name,urlkey,main_topic_id)
FROM topics.csv csv HEADER NULL 'not_found';

\copy Group_topic(topic_id,group_id)
FROM groups_topics.csv csv HEADER NULL 'not_found';

\copy Event(event_id,created,description,duration,fee_accepts,fee_amount,fee.required,group_id,headcount,how_to_find_us,maybe_rsvp_count,event_name,photo_url,rating.average,rating.count,event_status,event_time,updated,venue_id,visibility,waitlist_count,why,yes_rsvp_count)
FROM events.csv csv HEADER NULL 'not_found';

