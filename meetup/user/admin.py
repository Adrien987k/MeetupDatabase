from django.contrib import admin

from .models import *


class MyAdmin(admin.ModelAdmin):
    def has_add_permission(self, request):
        return False


admin.site.register(Category, MyAdmin)
admin.site.register(City, MyAdmin)
admin.site.register(Groups, MyAdmin)
admin.site.register(Member, MyAdmin)
admin.site.register(Topic, MyAdmin)
admin.site.register(GroupTopic, MyAdmin)
admin.site.register(TopicFollowed, MyAdmin)
admin.site.register(Venue, MyAdmin)
#admin.site.register(Websitemanager, MyAdmin)
#admin.site.register(ModeratorCategory, MyAdmin)
admin.site.register(Events, MyAdmin)
