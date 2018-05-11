# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Category(models.Model):
    category_id = models.IntegerField(primary_key=True)
    category_name = models.CharField(max_length=50)
    shortname = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'category'


class City(models.Model):
    city_id = models.IntegerField()
    city_name = models.CharField(primary_key=True, max_length=50)
    country = models.CharField(max_length=50)
    latitude = models.FloatField()
    longitude = models.FloatField()
    state = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'city'


class Event(models.Model):
    event_id = models.CharField(primary_key=True, max_length=20)
    group = models.ForeignKey(
        'Groups', models.DO_NOTHING, blank=True, null=True)
    created = models.DateTimeField()
    description = models.TextField(blank=True, null=True)
    duration = models.IntegerField()
    photo_url = models.TextField(blank=True, null=True)
    how_to_find_us = models.TextField(blank=True, null=True)
    event_name = models.CharField(max_length=100)
    event_status = models.TextField()  # This field type is a guess.
    event_time = models.DateTimeField()
    venue = models.ForeignKey(
        'Venue', models.DO_NOTHING, blank=True, null=True)
    updated = models.DateTimeField(blank=True, null=True)
    visibility = models.TextField()  # This field type is a guess.
    why = models.TextField(blank=True, null=True)
    headcount = models.IntegerField(blank=True, null=True)
    rating_average = models.FloatField(blank=True, null=True)
    rating_count = models.IntegerField()
    rsvp_limit = models.IntegerField()
    maybe_rsvp_count = models.IntegerField()
    yes_rsvp_count = models.IntegerField()
    waitlist_count = models.IntegerField()
    fee_accepts = models.TextField()  # This field type is a guess.
    fee_amount = models.FloatField(blank=True, null=True)
    fee_required = models.BooleanField()
    repinned = models.NullBooleanField()

    class Meta:
        managed = False
        db_table = 'event'


class GroupTopic(models.Model):
    group = models.ForeignKey(
        'Groups', models.DO_NOTHING, blank=True, null=True)
    topic = models.ForeignKey(
        'Topic', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'group_topic'


class Groups(models.Model):
    group_id = models.IntegerField(primary_key=True)
    created = models.DateTimeField()
    category = models.ForeignKey(
        Category, models.DO_NOTHING, blank=True, null=True)
    description = models.TextField()
    join_mode = models.TextField()  # This field type is a guess.
    organizer_id = models.IntegerField(blank=True, null=True)
    group_name = models.CharField(max_length=100, blank=True, null=True)
    city_name = models.ForeignKey(
        City, models.DO_NOTHING, db_column='city_name', blank=True, null=True)
    visibility = models.TextField()  # This field type is a guess.
    who = models.CharField(max_length=50, blank=True, null=True)
    photo_photo_link = models.CharField(max_length=200, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'groups'


class Member(models.Model):
    member_group_id = models.Field(primary_Key=True)
    member_id = models.IntegerField(blanck=True, null=True)
    group_id = models.IntegerField(blank=True, null=True)
    member_name = models.CharField(max_length=50)
    member_status = models.TextField()  # This field type is a guess.
    joined = models.DateTimeField()
    bio = models.TextField(blank=True, null=True)
    city_name = models.CharField(max_length=50, blank=True, null=True)
    visited = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'member'


class ModeratorCategory(models.Model):
    user = models.ForeignKey(Member, models.DO_NOTHING, blank=True, null=True)
    category = models.ForeignKey(
        Category, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'moderator_category'


class Topic(models.Model):
    topic_id = models.IntegerField(primary_key=True)
    description = models.TextField(blank=True, null=True)
    urlkey = models.CharField(max_length=50)
    topic_name = models.CharField(max_length=50)
    parent_topic_id = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'topic'


class TopicFollowed(models.Model):
    topic = models.ForeignKey(Topic, models.DO_NOTHING, blank=True, null=True)
    member = models.ForeignKey(
        Member, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'topic_followed'


class Venue(models.Model):
    venue_id = models.IntegerField(primary_key=True)
    address_1 = models.CharField(max_length=200, blank=True, null=True)
    venue_name = models.CharField(max_length=200, blank=True, null=True)
    city_name = models.CharField(max_length=50, blank=True, null=True)
    rating_average = models.FloatField()
    rating_count = models.FloatField()

    class Meta:
        managed = False
        db_table = 'venue'


class Websitemanager(models.Model):
    user_id = models.IntegerField(primary_key=True)
    user_name = models.CharField(max_length=50)
    joined = models.DateTimeField()
    manager_type = models.TextField()  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'websitemanager'
