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

    def __str__(self):
        return self.category_name


class City(models.Model):
    city_id = models.IntegerField()
    city_name = models.CharField(primary_key=True, max_length=50)
    country = models.CharField(max_length=50)
    latitude = models.FloatField()
    longitude = models.FloatField()
    state = models.CharField(max_length=50, blank=True, null=True)

    def __str__(self):
        return self.city_name


class Groups(models.Model):
    group_id = models.IntegerField(primary_key=True)
    created = models.DateTimeField()
    description = models.TextField(null=True)
    photo_photo_link = models.CharField(max_length=200, blank=True, null=True)
    join_mode = models.TextField()  # This field type is a guess.
    group_name = models.CharField(max_length=100, blank=True, null=True)
    organizer_id = models.IntegerField(blank=True, null=True)
    visibility = models.TextField()  # This field type is a guess.
    who = models.CharField(max_length=50, blank=True, null=True)
    category = models.ForeignKey(
        'Category', models.DO_NOTHING, blank=True, null=True)
    city_name = models.ForeignKey(
        'City', models.DO_NOTHING, db_column='city_name', blank=True, null=True)

    def __str__(self):
        return self.group_name

    def rating(self):
        events = Events.objects.filter(group_id=self.group_id)
        average = 0
        sum = 0
        for event in events:
            count = event.rating_count
            if count == -1:
                count = 0
            average += event.rating_average * count
            sum += count
        if sum != 0:
            average = average/sum
        return(average, sum)


class Member(models.Model):
    member_id = models.IntegerField()
    bio = models.TextField()
    city_name = models.CharField(max_length=50, blank=True, null=True)
    joined = models.DateTimeField()
    member_name = models.CharField(max_length=50)
    member_status = models.TextField()  # This field type is a guess.
    visited = models.DateTimeField()
    group_id = models.IntegerField(blank=True, null=True)

    def __str__(self):
        return self.member_name


class Topic(models.Model):
    topic_id = models.IntegerField(primary_key=True)
    description = models.TextField(blank=True, null=True)
    urlkey = models.CharField(max_length=50)
    topic_name = models.CharField(max_length=50)
    parent_topic_id = models.IntegerField(blank=True, null=True)

    def __str__(self):
        return self.topic_name


class GroupTopic(models.Model):
    topic = models.ForeignKey(
        'Topic', models.DO_NOTHING, blank=True, null=True)
    group = models.ForeignKey(
        'Groups', models.DO_NOTHING, blank=True, null=True)


class TopicFollowed(models.Model):
    topic = models.ForeignKey(Topic, models.DO_NOTHING, blank=True, null=True)
    member = models.ForeignKey(
        'Member', models.DO_NOTHING, blank=True, null=True)


class Venue(models.Model):
    venue_id = models.IntegerField(primary_key=True)
    address_1 = models.CharField(max_length=200, blank=True, null=True)
    city_name = models.CharField(max_length=50, blank=True, null=True)
    venue_name = models.CharField(max_length=200, blank=True, null=True)
    rating_average = models.FloatField()
    rating_count = models.FloatField()

    def __str__(self):
        return self.venue_name


class Websitemanager(models.Model):
    user_id = models.IntegerField(primary_key=True)
    user_name = models.CharField(max_length=50)
    joined = models.DateTimeField()
    manager_type = models.TextField()  # This field type is a guess.

    def __str__(self):
        return self.user_name


class ModeratorCategory(models.Model):
    user = models.ForeignKey(
        Websitemanager, models.DO_NOTHING, blank=True, null=True)
    category = models.ForeignKey(
        'Category', models.DO_NOTHING, blank=True, null=True)


class Events(models.Model):
    event_id = models.CharField(primary_key=True, max_length=20)
    created = models.DateTimeField()
    description = models.TextField(blank=True, null=True)
    duration = models.IntegerField()
    fee_accepts = models.TextField()  # This field type is a guess.
    fee_amount = models.FloatField(blank=True, null=True)
    fee_required = models.BooleanField()
    group = models.ForeignKey(
        'Groups', models.DO_NOTHING, blank=True, null=True)
    headcount = models.IntegerField(blank=True, null=True)
    how_to_find_us = models.TextField(blank=True, null=True)
    maybe_rsvp_count = models.IntegerField()
    event_name = models.CharField(max_length=100)
    photo_url = models.TextField(blank=True, null=True)
    rating_average = models.FloatField(blank=True, null=True)
    rating_count = models.IntegerField()
    rsvp_limit = models.IntegerField()
    event_status = models.TextField()  # This field type is a guess.
    event_time = models.DateTimeField()
    updated = models.DateTimeField(blank=True, null=True)
    venue = models.ForeignKey(
        'Venue', models.DO_NOTHING, blank=True, null=True)
    repinned = models.NullBooleanField()
    visibility = models.TextField()  # This field type is a guess.
    waitlist_count = models.IntegerField()
    why = models.TextField(blank=True, null=True)
    yes_rsvp_count = models.IntegerField()

    def __str__(self):
        return self.event_name

    def in_range(self, date1, date2):
        return(self.event_time >= date1 and self.event_time < date2)
