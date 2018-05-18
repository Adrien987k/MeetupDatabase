from django.shortcuts import render

# Create your views here.
from django.http import HttpResponse, HttpResponseRedirect, Http404
from django.shortcuts import get_object_or_404, render
from django.urls import reverse
from django.views import generic

from django.db.models import Max
from .models import *
from django.utils import timezone
import datetime
import pytz
from .forms import AuthForm

from random import randint

utc=pytz.UTC

max_member_id = 240852082

def esc(word):
    """
    Erases the potential '\' at the beginning of word
    """
    if len(word) != 0 and word[0] == '/':
        return(word[1:len(word)])
    else:
        return(word)
    

#*** User ***********************


def Auth(request):
    return render(request, 'user/index.html', {})


def UserLogin(request):
    return render(request, 'user/user_login.html', {})


def UserLogged(request):
    user_id = int(esc(request.GET['id']))
    name = esc(request.GET['name'])
    memgrs = Member.objects.filter(member_id=user_id)
    
    if len(memgrs) == 0 or memgrs[0].member_name != name:
        return render(request, 'user/user_login.html', {'error_message' : "Sorry, this user doesn't exist"})
    else:
        user = memgrs[0]

    now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    return render(request, 'user/user_logged.html', {'user_id' : user_id})


def UserIndex(request, user_id):
    memgrs = Member.objects.filter(member_id=user_id)
    if len(memgrs) == 0:
        raise Http404("This member does not exist")
    else:
        user = memgrs[0]
    
    now = datetime.datetime.now()
    user.visited = now.replace(tzinfo=utc)
    user.save()
    
    now = now.strftime("%Y-%m-%d %H:%M:%S")
    return render(request, 'user/user_index.html', {'now' : now, 'user' : user})

def UserCreate(request):
        
    cities = City.objects.all()
    return render(request, 'user/user_create.html', {'cities' : cities})


def UserCreation(request):
    cities = City.objects.all()
    now = datetime.datetime.now().replace(tzinfo=utc)
    
    try:
        name = request.POST['name']
        if len(name) > 50:
            return render(request, 'user/user_create.html', {'user_id' : user_id, 'cities' : cities, 'error_message' : "Too long name"})
        
        bio = request.POST['bio']
        city_name = request.POST['city_name']
        
    except KeyError:
        return render(request, 'user/user_create.html', {'user_id' : user_id, 'cities' : cities, 'error_message' : "You didn't select a choice"})

    user_id = Member.objects.all().aggregate(Max('member_id'))['member_id__max'] + 1
    groups = Groups.objects.all()
    rand_group_id = groups[randint(0,len(groups)-1)].group_id
    Member.objects.create(member_id=user_id, city_name=city_name, joined=now, member_name=name, member_status="active", visited=now, group_id=rand_group_id)
    
    return render(request, 'user/user_created.html', {'user_id' : user_id})


# *** Category ***********************


def CategoryIndex(request, user_id):
    category_list = Category.objects.all()
    return render(request, 'user/category_index.html', {'user_id' : user_id, 'category_list' : category_list})


def CategoryDetail(request, user_id, category_id):
    category = get_object_or_404(Category, pk=category_id)
    group_count = Groups.objects.filter(category_id = category_id).count()
    
    return render(request, 'user/category_detail.html', {'user_id' : user_id, 'category': category, 'group_count' : group_count})


# *** City ***********************


def CityIndex(request, user_id):
    city_list = City.objects.all()
    return render(request, 'user/city_index.html', {'user_id' : user_id, 'city_list' : city_list})


def CityDetail(request, user_id, city_name):
    city = get_object_or_404(City, pk=city_name)
    member_count = Member.objects.filter(city_name = city_name).distinct('member_id').count()
    group_count = Groups.objects.filter(city_name = city_name).count()
    
    venues = Venue.objects.filter(city_name = city_name)
    venue_count = venues.count
    event_count = Events.objects.filter(venue_id__in=[q.venue_id for q in venues]).distinct('event_name').count()
    
    now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    return render(request, 'user/city_detail.html', {'user_id' : user_id, 'city': city, 'member_count' : member_count, 'group_count' : group_count, 'venue_count' : venue_count, 'event_count' : event_count, 'now' : now})


# *** Topics ***********************


def TopicIndex(request, user_id):
    topic_list = Topic.objects.all().order_by('topic_name')
    return render(request, 'user/topic_index.html', {'user_id' : user_id, 'topic_list' : topic_list})


def TopicDetail(request, user_id, topic_id):
    topic = get_object_or_404(Topic, pk=topic_id)
    follows = 0
    if TopicFollowed.objects.filter(topic_id=topic_id, member_id=user_id).exists():
        follows = 1
    
    try:
        parent_topic = Topic.objects.get(pk=topic.parent_topic_id)
        have_parent = True
    except Topic.DoesNotExist:
        parent_topic = Topic.objects.none()
        have_parent = False
        
    now = datetime.datetime.now()
    prev = (now-datetime.timedelta(days=365)).strftime("%Y-%m-%d %H:%M:%S")
    now = now.strftime("%Y-%m-%d %H:%M:%S")

    member_query = TopicFollowed.objects.filter(topic_id=topic_id)
    member_id_list = [q.member_id for q in member_query]
    member_count = Member.objects.filter(member_id__in=member_id_list).distinct('member_id').count()
    group_count = GroupTopic.objects.filter(topic_id = topic_id).count
    
    return render(request, 'user/topic_detail.html', {'user_id' : user_id, 'topic': topic, 'parent_topic' : parent_topic, 'group_count' : group_count, 'have_parent' : have_parent, 'member_count' : member_count, 'now' : now, 'prev' : prev, 'follows' : follows})

def TopicFollow(request, user_id, topic_id, follows):
    topic = get_object_or_404(Topic, pk=topic_id)

    if follows == 1:
        
        mems = TopicFollowed.objects.filter(member_id=user_id)
        memgrs = mems.filter(topic_id=topic_id)
        
        if len(memgrs) == 0:
            raise Http404("This user doesn't follow this topic")
        else:
            memgrs.delete()
                
    else:
        if not Member.objects.filter(member_id=user_id).exists():
            Http404("This user doesn't exist")
            
        else:
            TopicFollowed.objects.create(member_id=user_id,topic_id=topic_id)
                
    return render(request, 'user/topic_followed.html', {'user_id' : user_id, 'topic' : topic, 'follows' : follows})


# *** Groups ***********************


def GroupIndex(request, user_id, filt, filt_pk):
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
        filt_name = ""
        
    return render(request, 'user/group_index.html', {'user_id' : user_id, 'group_list': group_list.order_by('group_name'), 'filt': filt, 'filt_name': filt_name})


def GroupDetail(request, user_id, group_id):
    group = get_object_or_404(Groups, pk=group_id)
    organizers = Member.objects.filter(member_id=group.organizer_id)
    organizer = Member.objects.get(pk=1) # default
    category_name=Category.objects.get(pk=group.category_id).category_name
    
    closed = group.join_mode == "closed"
    average,count = group.rating()
    have_photo = Groups.objects.filter(pk=group_id,photo_photo_link__isnull=False).exists()
    
    if len(organizers) == 0:
        have_org = False
    else:
        organizer = organizers[0]
        have_org = True

    now = datetime.datetime.now()
    prev = (now-datetime.timedelta(days=365)).strftime("%Y-%m-%d %H:%M:%S")
    now = now.strftime("%Y-%m-%d %H:%M:%S")
    memgrs = Member.objects.filter(group_id=group_id)
    is_member = 0
    
    if memgrs.filter(member_id=user_id).exists():
        is_member = 1
    visible = group.visibility == "public" or is_member == 1
    member_count = memgrs.distinct('member_id').count()
    topic_query = GroupTopic.objects.filter(group_id = group_id)
    topic_list = [q.topic_id for q in topic_query]
    topics = Topic.objects.filter(topic_id__in=topic_list)
    
    return render(request, 'user/group_detail.html', {'user_id' : user_id, 'group': group, 'topics' : topics, 'organizer' : organizer,'have_org' : have_org, 'member_count' : member_count, 'now' : now, 'prev' : prev, 'is_member' : is_member, 'average' : average, 'count' : count, 'have_photo' : have_photo, 'closed' : closed, 'visible' : visible, 'category_name' : category_name})


def GroupJoin(request, user_id, group_id, is_member):
    group = get_object_or_404(Groups, pk=group_id)
    now = datetime.datetime.now().replace(tzinfo=utc)
    
    error = False
    wait = False
    closed = False
    if is_member == 1:
        
        mems = Member.objects.filter(member_id=user_id)
        memgrs = mems.filter(group_id=group_id)
        
        if len(memgrs) == 0:
            raise Http404("This user isn't member of this group")
        else:
            if len(mems) == 1:
                error = True
            else:
                memgrs.delete()
                
    else:
        memgrs = Member.objects.filter(member_id=user_id)
        if len(memgrs) == 0:
            Http404("This user doesn't exist")
            
        else:
            if group.join_mode == "approval":
                wait = True
            elif group.join_mode == "closed":
                closed = True
                
            else:
                m = memgrs[0]
                Member.objects.create(member_id=user_id, city_name=m.city_name, joined=m.joined, member_name=m.member_name, member_status=m.member_status, visited=now, group_id=group_id)
                
    return render(request, 'user/group_joinresults.html', {'user_id' : user_id, 'group' : group, 'is_member' : is_member, 'error' : error, 'wait' : wait, 'closed' : closed})


def GroupCreate(request, user_id, member_id):
    if user_id != member_id:
        raise Http404("Error. Wrong way to create a group")
        
    cities = City.objects.all()
    categories = Category.objects.all()
    return render(request, 'user/group_create.html', {'cities' : cities, 'user_id' : user_id, 'categories' : categories})


def GroupCreation(request, user_id, member_id):
    if user_id != member_id:
        raise Http404("Error. Wrong way to create a group")
    cities = City.objects.all()
    categories = Category.objects.all()
    now = datetime.datetime.now().replace(tzinfo=utc)
    
    try:
        name = request.POST['name']
        if len(name) > 100:
            return render(request, 'user/group_create.html', {'user_id' : user_id, 'cities' : cities, 'categories' : categories, 'error_message' : "Too long name"})
        
        description = request.POST['description']
        photo = request.POST['photo']
        visibility = request.POST['visibility']
        join_mode = request.POST['join_mode']
        city_name = request.POST['city_name']
        city = City.objects.get(pk=city_name)
        category_id = int(request.POST['category_id'])
        who = request.POST['who']

        if len(who) > 50:
            return render(request, 'user/group_create.html', {'user_id' : user_id, 'cities' : cities, 'categories' : categories, 'error_message' : "Too long members name"})
        
    except KeyError:
        return render(request, 'user/group_create.html', {'user_id' : user_id, 'cities' : cities, 'categories' : categories, 'error_message' : "You didn't select a choice"})

    group_id = Groups.objects.all().aggregate(Max('group_id'))['group_id__max'] + 1
    
    Groups.objects.create(group_id=group_id, created=now, description=description, photo_photo_link=photo, join_mode=join_mode, group_name=name, organizer_id=user_id, visibility=visibility, who=who, category_id=category_id, city_name=city)
    
    return render(request, 'user/group_created.html', {'user_id' : user_id, 'group_id' : group_id})

def GroupModif(request, user_id, group_id):
    group = get_object_or_404(Groups, pk=group_id)
    if user_id != group.organizer_id:
        raise Http404("You are not allowed to alter this")
        
    cities = City.objects.all()
    categories = Category.objects.all()
    return render(request, 'user/group_modif.html', {'cities' : cities, 'user_id' : user_id, 'categories' : categories, 'group' : group})


def GroupModification(request, user_id, group_id):
    group = get_object_or_404(Groups, pk=group_id)
    if user_id != group.organizer_id:
        raise Http404("You are not allowed to alter this")
    cities = City.objects.all()
    categories = Category.objects.all()
    
    try:
        name = request.POST['name']
        if len(name) > 100:
            return render(request, 'user/group_create.html', {'user_id' : user_id, 'cities' : cities, 'categories' : categories, 'error_message' : "Too long name"})
        
        description = request.POST['description']
        photo = request.POST['photo']
        visibility = request.POST['visibility']
        join_mode = request.POST['join_mode']
        city_name = request.POST['city_name']
        city = City.objects.get(pk=city_name)
        category_id = int(request.POST['category_id'])
        who = request.POST['who']

        if len(who) > 50:
            return render(request, 'user/group_create.html', {'user_id' : user_id, 'cities' : cities, 'categories' : categories, 'error_message' : "Too long members name"})
        
    except KeyError:
        return render(request, 'user/group_create.html', {'user_id' : user_id, 'cities' : cities, 'categories' : categories, 'error_message' : "You didn't select a choice"})

    group.group_name = name
    group.description = description
    group.photo_photo_link = photo
    group.jon_mode = join_mode
    group.visibility = visibility
    group.who = who
    group.category_id = category_id
    group.city_name = city
    group.save()
    
    return render(request, 'user/group_modified.html', {'user_id' : user_id, 'group_id' : group_id})


def GroupSelect(request, user_id, group_id):
    group = get_object_or_404(Groups, pk=group_id)
    if user_id != group.organizer_id:
        raise Http404("You are not allowed to alter this")
    followed = GroupTopic.objects.filter(group_id=group_id)
    tpflwd = Topic.objects.filter(topic_id__in=[q.topic_id for q in followed])
    topics = Topic.objects.all().difference(tpflwd).order_by('topic_name')

    return render(request, 'user/group_select.html', {'user_id' : user_id, 'group' : group, 'topics' : topics, 'followed' : tpflwd})


def GroupSelection(request, user_id, group_id):
    group = get_object_or_404(Groups, pk=group_id)
    if user_id != group.organizer_id:
        raise Http404("You are not allowed to alter this")
    followed = GroupTopic.objects.filter(group_id=group_id)
    tpflwd = Topic.objects.filter(topic_id__in=[q.topic_id for q in followed])
    topics = Topic.objects.all().difference(tpflwd).order_by('topic_name')
    
    try:
        topics = request.POST.getlist('topic')
        
    except KeyError:
        return render(request, 'user/group_select.html', {'user_id' : user_id, 'group' : group, 'topics' : topics, 'followed' : tpflwd})

    for topic in followed.difference(followed.filter(topic_id__in=topics)):
        GroupTopic.objects.get(topic_id=topic.topic_id,group_id=group_id).delete()
    for topic_id in topics:
        GroupTopic.objects.update_or_create(group_id=group_id, topic_id=topic_id)
    
    return render(request, 'user/group_selected.html', {'user_id' : user_id, 'group_id' : group_id})


# *** Venue ***********************


def VenueIndex(request, user_id, filt, filt_pk, page):
    if filt == "city":
        venue_list = Venue.objects.filter(city_name=filt_pk)
        filt_name = filt_pk
        
    else:
        venue_list = Venue.objects.all()
        filt_name = ""

    venue_list = venue_list.distinct('venue_name').order_by('venue_name')
    page_max = len(venue_list) // 1000 + 1
    next_page = page + 1
    prev_page = page - 1
    
    if page == page_max:
        next_page = 1
    if page == 1:
        prev_page = page_max
    venue_list = venue_list[1000*(page-1):min(1000*page,len(venue_list))]
    
    return render(request, 'user/venue_index.html', {'user_id' : user_id, 'venue_list': venue_list, 'filt' : filt, 'filt_name' : filt_name, 'page' : page, 'filt_pk' : filt_pk, 'next_page' : next_page, 'prev_page' : prev_page})


def VenueDetail(request, user_id, venue_id):
    venue = get_object_or_404(Venue, pk=venue_id)
    rating_count = int(venue.rating_count)
    if rating_count == -1:
        rating_count = 0
        
    event_count = Events.objects.filter(venue_id=venue_id).distinct('event_name').count()
    now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    votes = range(0,6)
    
    return render(request, 'user/venue_detail.html', {'user_id' : user_id, 'venue': venue, 'rating_count': rating_count, 'event_count' : event_count, 'now' : now, 'votes' : votes})

def VenueVote(request, user_id, venue_id):
    venue = get_object_or_404(Venue, pk=venue_id)
    rating_count = int(venue.rating_count)
    if rating_count == -1:
        rating_count = 0
        
    now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    votes = range(0,6)
    event_count = Events.objects.filter(venue_id=venue_id).distinct('event_name').count()
    
    try:
        vote = int(request.POST['choice'])
    except KeyError:
        # Redisplay the question voting form.
        return render(request, 'user/venue_detail.html', {'user_id' : user_id, 'venue': venue, 'rating_count': rating_count, 'event_count' : event_count, 'now' : now, 'error_message' : "You didn't select a choice", 'votes' : votes})
    
    else:
        venue.rating_average = (venue.rating_average * rating_count + vote) / (rating_count + 1)
        venue.rating_count = rating_count + 1
        venue.save()
        
        return render(request, 'user/venue_results.html', {'user_id' : user_id, 'venue' : venue})

    
# *** Member ***********************


def MemberIndex(request, user_id, filt, filt_pk, page):
    if filt == "group":
        member_list = Member.objects.filter(group_id=filt_pk)
        filt_name = Groups.objects.get(pk=filt_pk).group_name
        
    elif filt == "city":
        member_list = Member.objects.filter(city_name=filt_pk)
        filt_name = filt_pk
        
    elif filt == "topic":
        member_query = TopicFollowed.objects.filter(topic_id=filt_pk)
        member_id_list = [q.member_id for q in member_query]
        member_list = Member.objects.filter(member_id__in=member_id_list)
        filt_name = Topic.objects.get(pk=filt_pk).topic_name
        
    else:
        member_list = Member.objects.all()
        filt_name = ""

    member_list = member_list.distinct('member_name').order_by('member_name')
    page_max = len(member_list) // 1000 + 1
    next_page = page + 1
    prev_page = page - 1
    
    if page == page_max:
        next_page = 1
    if page == 1:
        prev_page = page_max
    member_list = member_list[1000*(page-1):min(1000*page,len(member_list))]
        
    return render(request, 'user/member_index.html', {'user_id' : user_id, 'member_list': member_list, 'filt' : filt, 'filt_name' : filt_name, 'filt_pk' : filt_pk, 'page' : page, 'next_page' : next_page, 'prev_page' : prev_page})


def MemberDetail(request, user_id, member_id):
    memgrs = Member.objects.filter(member_id=member_id)
    if len(memgrs) == 0:
        raise Http404("This member does not exist")
    else:
        member = memgrs[0]
        
    groups = Groups.objects.filter(group_id__in=[q.group_id for q in memgrs])
    topic_query = TopicFollowed.objects.filter(member_id=member_id)
    topic_list = [q.topic_id for q in topic_query]
    topics = Topic.objects.filter(topic_id__in=topic_list)
    
    return render(request, 'user/member_detail.html', {'user_id' : user_id, 'member': member, 'groups' : groups, 'topics' : topics})


def MemberDelete(request, user_id, member_id):
    if member_id != user_id:
        raise Http404("You are not allowed to do this")
    
    memgrs = Member.objects.filter(member_id=user_id)
    if len(memgrs) == 0:
        raise Http404("This member does not exist")
    else:
        member = memgrs[0]
        
    return render(request, 'user/member_delete.html', {'user_id' : user_id, 'member': member})


def MemberDeletion(request, user_id, member_id):
    if member_id != user_id:
        raise Http404("You are not allowed to do this")
    
    memgrs = Member.objects.filter(member_id=user_id)
    if len(memgrs) == 0:
        raise Http404("This member does not exist")
    else:
        memgrs.delete()
    
    return render(request, 'user/member_deleted.html', {})


def MemberModif(request, user_id, member_id):
    if member_id != user_id:
        raise Http404("You are not allowed to do this")
    
    memgrs = Member.objects.filter(member_id=user_id)
    if len(memgrs) == 0:
        raise Http404("This member does not exist")
    else:
        member = memgrs[0]
        
    cities = City.objects.all()
    return render(request, 'user/member_modif.html', {'user_id' : user_id, 'member': member, 'cities' : cities})


def MemberModification(request, user_id, member_id):
    cities = City.objects.all()
    if member_id != user_id:
        raise Http404("You are not allowed to do this")
    
    memgrs = Member.objects.filter(member_id=user_id)
    if len(memgrs) == 0:
        raise Http404("This member does not exist")
    
    else:
        member = memgrs[0]
        try:
            name = request.POST['name']
            if len(name) > 50:
                return render(request, 'user/member_modif.html', {'user_id' : user_id, 'member': member, 'cities' : cities, 'error_message' : "Too long name"})
        
            bio = request.POST['bio']
            city_name = request.POST ['city_name']
        
        except KeyError:
            # Redisplay the question voting form.
            return render(request, 'user/member_modif.html', {'user_id' : user_id, 'member': member, 'cities' : cities, 'error_message' : "You didn't select a choice"})
        for member in memgrs:
            member.member_name = name
            member.city_name = city_name
            member.bio = bio
            member.save()
    
    return render(request, 'user/member_modified.html', {'user_id' : user_id})


def MemberSelect(request, user_id, member_id):
    memgrs = Member.objects.filter(member_id=member_id)
    if len(memgrs) == 0:
        raise Http404("This member does not exist")
    else:
        member = memgrs[0]
    if member_id != user_id:
        raise Http404("You are not allowed to do this")

    followed = TopicFollowed.objects.filter(member_id=member_id)
    tpflwd = Topic.objects.filter(topic_id__in=[q.topic_id for q in followed])
    topics = Topic.objects.all().difference(tpflwd).order_by('topic_name')

    return render(request, 'user/member_select.html', {'user_id' : user_id, 'member' : member, 'topics' : topics, 'followed' : tpflwd})


def MemberSelection(request, user_id, member_id):
    memgrs = Member.objects.filter(member_id=member_id)
    if len(memgrs) == 0:
        raise Http404("This member does not exist")
    else:
        member = memgrs[0]
    if member_id != user_id:
        raise Http404("You are not allowed to do this")
    
    followed = TopicFollowed.objects.filter(member_id=member_id)
    tpflwd = Topic.objects.filter(topic_id__in=[q.topic_id for q in followed])
    topics = Topic.objects.all().difference(tpflwd).order_by('topic_name')
    
    try:
        topics = request.POST.getlist('topic')
        
    except KeyError:
        return render(request, 'user/member_select.html', {'user_id' : user_id, 'member' : member, 'topics' : topics, 'followed' : tpflwd})

    for topic in followed.difference(followed.filter(topic_id__in=topics)):
        TopicFollowed.objects.get(topic_id=topic.topic_id,member_id=member_id).delete()
    for topic_id in topics:
        TopicFollowed.objects.create(member_id=member_id, topic_id=topic_id)
    
    return render(request, 'user/member_selected.html', {'user_id' : user_id, 'member_id' : member_id})


#*** Event ***********************


def EventIndex(request,user_id, filt,filt_pk,date):
    date = datetime.datetime.strptime(date, '%Y-%m-%d %H:%M:%S')
    next_date = date+datetime.timedelta(days=365)
    prev_date = date-datetime.timedelta(days=365)
    date = date.replace(tzinfo=utc)
    next_date = next_date.replace(tzinfo=utc)
    prev_date = prev_date.replace(tzinfo=utc)
    
    if filt == "group":
        event_list = Events.objects.filter(group_id=filt_pk) 
        filt_name = Groups.objects.get(pk=filt_pk).group_name
        
    elif filt == "city":
        venue_query = Venue.objects.filter(city_name=filt_pk)
        event_list = Events.objects.filter(venue_id__in=[q.venue_id for q in venue_query])
        filt_name = filt_pk
        
    elif filt == "topic":
        group_query = GroupTopic.objects.filter(topic_id=filt_pk)
        group_id_list = [q.group_id for q in group_query]
        event_list = Events.objects.filter(group_id__in=group_id_list)
        filt_name = Topic.objects.get(pk=filt_pk).topic_name
        
    elif filt == "venue":
        event_list = Events.objects.filter(venue_id = filt_pk)
        filt_name = Venue.objects.get(pk=filt_pk).venue_name
        
    else:
        event_list = Events.objects.all()
        filt_name = ""

    event_list = [q for q in event_list.distinct('event_name') if q.event_time >= date and q.event_time < next_date]
    
    return render(request, 'user/event_index.html', {'user_id' : user_id, 'event_list': event_list, 'filt' : filt, 'filt_name' : filt_name, 'filt_pk' : filt_pk, 'date' : date.strftime("%Y-%m-%d %H:%M:%S"), 'next_date' : next_date.strftime("%Y-%m-%d %H:%M:%S"), 'prev_date' : prev_date.strftime("%Y-%m-%d %H:%M:%S")})
                                    

def EventDetail(request, user_id, event_id):
    event = get_object_or_404(Events, pk=event_id)
    rating_count = event.rating_count
    if rating_count == -1:
        rating_count = 0
    duration = event.duration / 3600
    
    try:
        org_group = Groups.objects.get(pk=event.group_id)
        have_org = True
    except Groups.DoesNotExist:
        have_org = False
    
    try:
        venue = Venue.objects.get(pk=event.venue_id)
        have_venue = True
    except Venue.DoesNotExist:
        have_venue = False
        
    past = datetime.datetime.now().replace(tzinfo=utc) > event.event_time
    votes = range(0,6)
   
    return render(request, 'user/event_detail.html', {'user_id' : user_id, 'event': event, 'duration' : duration, 'org_group' : org_group, 'have_org' : have_org, 'venue' : venue, 'have_venue' : have_venue, 'past' : past, 'votes' : votes, 'rating_count' : rating_count})


def EventVote(request, user_id, event_id):
    event = get_object_or_404(Events, pk=event_id)
    rating_count = event.rating_count
    if rating_count == -1:
        rating_count = 0
    duration = event.duration / 3600
    
    try:
        org_group = Groups.objects.get(pk=event.group_id)
        have_org = True
    except Groups.DoesNotExist:
        have_org = False
        
    try:
        venue = Venue.objects.get(pk=event.venue_id)
        have_venue = True
    except Venue.DoesNotExist:
        have_venue = False
        
    past = datetime.datetime.now().replace(tzinfo=utc) > event.event_time
    votes = range(0,6)
    
    try:
        vote = int(request.POST['choice'])
    except KeyError:
        # Redisplay the question voting form.
        return render(request, 'user/event_detail.html', {'user_id' : user_id, 'event': event, 'duration' : duration, 'org_group' : org_group, 'have_org' : have_org, 'venue' : venue, 'have_venue' : have_venue, 'past' : past, 'rating_count' : rating_count, 'error_message' : "You didn't select a choice", 'votes' : votes})
    
    else:
        event.rating_average = (event.rating_average * rating_count + vote) / (rating_count + 1)
        event.rating_count = rating_count + 1
        event.save()
        return render(request, 'user/event_results.html', {'user_id' : user_id, 'event' : event})

    
def EventJoin(request, user_id, event_id):
    event = get_object_or_404(Events, pk=event_id)
    rating_count = event.rating_count
    if rating_count == -1:
        rating_count = 0
    duration = event.duration / 3600
    
    try:
        org_group = Groups.objects.get(pk=event.group_id)
        have_org = True
    except Groups.DoesNotExist:
        have_org = False
        
    try:
        venue = Venue.objects.get(pk=event.venue_id)
        have_venue = True
    except Venue.DoesNotExist:
        have_venue = False
        
    past = datetime.datetime.now().replace(tzinfo=utc) > event.event_time
    votes = range(0,6)
    
    try:
        yes = int(request.POST['yes'])
    except KeyError:
        # Redisplay the question voting form.
        return render(request, 'user/event_detail.html', {'user_id' : user_id, 'event': event, 'duration' : duration, 'org_group' : org_group, 'have_org' : have_org, 'venue' : venue, 'have_venue' : have_venue, 'past' : past, 'rating_count' : rating_count, 'error_message' : "You didn't select a choice", 'votes' : votes})
    
    else:
        wait = False
        if yes == 1:
            if event.rsvp_limit != -1 and event.rsvp_limit <= event.yes_rsvp_count:
                event.waitlist_count += 1
                wait = True
            else:
                event.yes_rsvp_count += 1
        else:
            event.maybe_rsvp_count += 1
        event.save()
        
        return render(request, 'user/event_joinresults.html', {'user_id' : user_id, 'event' : event, 'wait' : wait, 'yes' : yes})
