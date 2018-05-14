from django.urls import path

from . import views

urlpatterns = [
    path('', views.Index.as_view(), name='index'),
    path('category/',views.CategoryIndex.as_view(),name='category_index'),
    path('category/<int:category_id>/', views.CategoryDetail, name='category_detail'),
    path('city/',views.CityIndex.as_view(),name='city_index'),
    path('city/<str:city_name>/', views.CityDetail, name='city_detail'),
    path('topic/',views.TopicIndex.as_view(),name='topic_index'),
    path('topic/<int:topic_id>/', views.TopicDetail, name='topic_detail'),
    path('<str:filt>/<int:filt_pk>/group/',views.GroupIndex,name='group_index'),
    path('<str:filt>/<str:filt_pk>/group/',views.GroupIndex,name='group_index'),
    path('group/<int:group_id>/', views.GroupDetail, name='group_detail'),
    path('<str:filt>/<int:filt_pk>/<int:page>/venue/',views.VenueIndex,name='venue_index'),
    path('<str:filt>/<str:filt_pk>/<int:page>/venue/',views.VenueIndex,name='venue_index'),
    path('venue/<int:venue_id>/', views.VenueDetail, name='venue_detail'),
    path('<str:filt>/<int:filt_pk>/<int:page>/member/',views.MemberIndex,name='member_index'),
    path('<str:filt>/<str:filt_pk>/<int:page>/member/',views.MemberIndex,name='member_index'),
    path('member/<int:member_id>/', views.MemberDetail, name='member_detail'),
]
