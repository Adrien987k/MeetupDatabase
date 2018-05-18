COPY auth_group
FROM auth_group.csv csv NULL 'not_found';

COPY auth_group_permissions
FROM auth_group_permissions.csv csv NULL 'not_found';

COPY auth_permission
FROM auth_permission.csv csv NULL 'not_found';

COPY auth_user
FROM auth_user.csv csv NULL 'not_found';

COPY auth_user_groups
FROM auth_user_groups.csv csv NULL 'not_found';

COPY auth_user_user_permissions
FROM auth_user_user_permissions.csv csv NULL 'not_found';