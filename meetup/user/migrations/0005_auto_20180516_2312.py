# Generated by Django 2.0.5 on 2018-05-16 21:12

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('user', '0004_auto_20180516_2307'),
    ]

    operations = [
        migrations.RenameField(
            model_name='topicfollowed',
            old_name='member',
            new_name='member_id',
        ),
    ]
