
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

CREATE INDEX user_topicfollowed_member_id ON public.user_topicfollowed
USING btree (member_id) TABLESPACE pg_default;
