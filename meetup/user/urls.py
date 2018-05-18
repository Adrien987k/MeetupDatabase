from django.urls import path

from . import views

urlpatterns = [
    path('', views.Auth, name='index'),
    path('user_login/', views.UserLogin, name='user_login'),
    path('user_logged/', views.UserLogged, name='user_logged'),
    path('<int:user_id>/', views.UserIndex, name='user_index'),
    path('create/', views.UserCreate, name='user_create'),
    path('creation/', views.UserCreation, name='user_creation'),
    
    path('<int:user_id>/category/', views.CategoryIndex, name='category_index'),
    path('<int:user_id>/category/<int:category_id>/',
         views.CategoryDetail, name='category_detail'),
    
    path('<int:user_id>/city/', views.CityIndex, name='city_index'),
    path('<int:user_id>/city/<str:city_name>/', views.CityDetail, name='city_detail'),
    
    path('<int:user_id>/topic/', views.TopicIndex, name='topic_index'),
    path('<int:user_id>/topic/<int:topic_id>/', views.TopicDetail, name='topic_detail'),
    path('<int:user_id>/group/<int:topic_id>/follow/<int:follows>', views.TopicFollow, name='topic_follow'),
    
    path('<int:user_id>/<str:filt>/<int:filt_pk>/group/',
         views.GroupIndex, name='group_index'),
    path('<int:user_id>/<str:filt>/<str:filt_pk>/group/',
         views.GroupIndex, name='group_index'),
    path('<int:user_id>/group/<int:group_id>/', views.GroupDetail, name='group_detail'),
    path('<int:user_id>/group/<int:group_id>/join/<int:is_member>', views.GroupJoin, name='group_join'),
    path('<int:user_id>/member/<int:member_id>/create', views.GroupCreate, name='group_create'),
    path('<int:user_id>/member/<int:member_id>/creation', views.GroupCreation, name='group_creation'),
    path('<int:user_id>/group/<int:group_id>/modif', views.GroupModif, name='group_modif'),
    path('<int:user_id>/group/<int:group_id>/modification', views.GroupModification, name='group_modification'),
    path('<int:user_id>/group/<int:group_id>/select', views.GroupSelect, name='group_select'),
    path('<int:user_id>/group/<int:group_id>/selection', views.GroupSelection, name='group_selection'),
    
    path('<int:user_id>/<str:filt>/<int:filt_pk>/<int:page>/venue/',
         views.VenueIndex, name='venue_index'),
    path('<int:user_id>/<str:filt>/<str:filt_pk>/<int:page>/venue/',
         views.VenueIndex, name='venue_index'),
    path('<int:user_id>/venue/<int:venue_id>/', views.VenueDetail, name='venue_detail'),
    path('<int:user_id>/venue/<int:venue_id>/vote', views.VenueVote, name='venue_vote'),
    
    path('<int:user_id>/<str:filt>/<int:filt_pk>/<int:page>/member/',
         views.MemberIndex, name='member_index'),
    path('<int:user_id>/<str:filt>/<str:filt_pk>/<int:page>/member/',
         views.MemberIndex, name='member_index'),
    path('<int:user_id>/member/<int:member_id>/', views.MemberDetail, name='member_detail'),
    path('<int:user_id>/member/<int:member_id>/delete', views.MemberDelete, name='member_delete'),
    path('<int:user_id>/member/<int:member_id>/deletion', views.MemberDeletion, name='member_deletion'),
    path('<int:user_id>/member/<int:member_id>/modif', views.MemberModif, name='member_modif'),
    path('<int:user_id>/member/<int:member_id>/modification', views.MemberModification, name='member_modification'),
    path('<int:user_id>/member/<int:member_id>/select', views.MemberSelect, name='member_select'),
    path('<int:user_id>/member/<int:member_id>/selection', views.MemberSelection, name='member_selection'),
    
    path('<int:user_id>/<str:filt>/<int:filt_pk>/<str:date>/event/',views.EventIndex,name='event_index'),
    path('<int:user_id>/<str:filt>/<str:filt_pk>/<str:date>/event/',views.EventIndex,name='event_index'),
    path('<int:user_id>/event/<str:event_id>/', views.EventDetail, name='event_detail'),
    path('<int:user_id>/event/<str:event_id>/vote', views.EventVote, name='event_vote'),
    path('<int:user_id>/event/<str:event_id>/join', views.EventJoin, name='event_join'),
    path('<int:user_id>/group/<int:group_id>/create', views.EventCreate, name='event_create'),
    path('<int:user_id>/group/<int:group_id>/creation', views.EventCreation, name='event_creation'),
    path('<int:user_id>/event/<str:event_id>/modif', views.EventModif, name='event_modif'),
    path('<int:user_id>/event/<str:event_id>/modification', views.EventModification, name='event_modification'),
]
