\copy Category(category_id,category_name,shortname)
FROM categories.csv csv HEADER NULL 'not_found';

\copy City(city_name,city_id,country,latitude,longitude,state)
FROM cities.csv csv HEADER NULL 'not_found';

\copy Member(member_id,bio,city_name,joined,member_name,member_status,visited)
FROM members.csv csv HEADER NULL 'not_found';

\copy Group(group_id,category_id,city_id,created,description,photo.base_url,photo.highres_link,photo.photo_link,photo.thumb_link,join_mode,group_name,organizer_id,visibility,who)
FROM groups.csv csv HEADER NULL 'not_found';


