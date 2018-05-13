from django.shortcuts import render

# Create your views here.
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import get_object_or_404, render
from django.urls import reverse
from django.views import generic

from .models import *


class Index(generic.ListView):
    template_name = 'user/index.html'

    def get_queryset(self):
        return ()

#*** Category ***

class CategoryIndex(generic.ListView):
    template_name = 'user/category_index.html'
    context_object_name = 'category_list'

    def get_queryset(self):
        return Category.objects.order_by('category_name')

def CategoryDetail(request, category_id):
    category = get_object_or_404(Category, pk=category_id)
    groups = Groups.objects.filter(category_id = category_id)
    return render(request, 'user/category_detail.html', {'category': category, 'groups' : groups})

#*** City ***

class CityIndex(generic.ListView):
    template_name = 'user/city_index.html'
    context_object_name = 'city_list'

    def get_queryset(self):
        return City.objects.order_by('city_name')

def CityDetail(request, city_name):
    city = get_object_or_404(City, pk=city_name)
    members = Member.objects.filter(city_name = city_name)
    groups = Groups.objects.filter(city_name = city_name)
    return render(request, 'user/city_detail.html', {'city': city, 'members' : members, 'groups' : groups})

#*** Topics ***

class TopicIndex(generic.ListView):
    template_name = 'user/topic_index.html'
    context_object_name = 'topic_list'

    def get_queryset(self):
        return Topic.objects.order_by('topic_name')

def TopicDetail(request, topic_id):
    topic = get_object_or_404(Topic, pk=topic_id)
    try:
        parent_topic = Topic.objects.get(pk=topic.parent_topic_id)
        have_parent = True
    except Topic.DoesNotExist:
        parent_topic = Topic.objects.none()
        have_parent = False
    groups = GroupTopic.objects.filter(topic_id = topic_id)
    return render(request, 'user/topic_detail.html', {'topic': topic, 'parent_topic' : parent_topic, 'groups' : groups, 'have_parent' : have_parent})

#*** Groups ***

def GroupIndex(request,filt,filt_pk):
    if filt == "category":
        group_list = Groups.objects.filter(category_id=filt_pk)
        filt_name = Category.objects.get(pk=filt_pk).category_name
    elif filt == "city":
        group_list = Groups.objects.filter(city_name=filt_pk)
        filt_name = filt_pk
    elif filt == "topic":
        group_query = GroupTopic.objects.filter(topic_id=filt_pk)
        group_id_list = [q.group_id for q in group_query]
        group_list = Groups.objects.filter(group_id__in=group_id_list)
        filt_name = Topic.objects.get(pk=filt_pk).topic_name
    else:
        group_list = Groups.objects.all()
    return render(request, 'user/group_index.html', {'group_list': group_list, 'filt' : filt, 'filt_name' : filt_name})

def GroupDetail(request, group_id):
    group = get_object_or_404(Groups, pk=group_id)
    topic_query = GroupTopic.objects.filter(group_id = group_id)
    topic_list = [q.topic_id for q in topic_query]
    topics = Topic.objects.filter(topic_id__in=topic_list)
    return render(request, 'user/group_detail.html', {'group': group, 'topics' : topics})

