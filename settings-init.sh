#!/bin/bash

# Settings Init - Wp Pro Club
# by DimaMinka (https://dimaminka.com)
# https://github.com/wp-pro-club/init

source ${PWD}/lib/app-init.sh

printf "${GRN}=======================${NC}\n"
printf "${GRN}Running settings script${NC}\n"
printf "${GRN}=======================${NC}\n"

# User
if [ ! -z "$conf_app_env_app_host" ] && [ ! -z "$conf_app_settings_admin_email" ] && [ ! -z "$conf_app_settings_admin_password" ] && [ ! -z "$conf_app_settings_admin_user" ] ; then
    wp core install --url="$conf_app_env_app_host" --title="$conf_app_env_app_host" --admin_user="$conf_app_settings_admin_user" --admin_password="$conf_app_settings_admin_password" --admin_email="$conf_app_settings_admin_email" --quiet
fi
if [ ! -z "$conf_app_settings_first_name" ] && [ ! -z "$conf_app_settings_last_name" ] ; then
    wp user update 1 --first_name=$conf_app_settings_first_name --last_name=$conf_app_settings_last_name --quiet
fi
# Discussion
if [ ! -z "$conf_app_settings_comment_moderation" ] ; then
    wp option update comment_moderation $conf_app_settings_comment_moderation --quiet
fi
if [ ! -z "$conf_app_settings_comment_registration" ] ; then
    wp option update comment_registration $conf_app_settings_comment_registration --quiet
fi
if [ ! -z "$conf_app_settings_default_comment_status" ] ; then
    wp option update default_comment_status $conf_app_settings_default_comment_status --quiet
fi
if [ ! -z "$conf_app_settings_default_pingback_flag" ] ; then
    wp option update default_pingback_flag $conf_app_settings_default_pingback_flag --quiet
fi
if [ ! -z "$conf_app_settings_default_ping_status" ] ; then
    wp option update default_ping_status $conf_app_settings_default_ping_status --quiet
fi
# General
if [ ! -z "$conf_app_settings_blogdescription" ] ; then
    wp option update blogdescription "$conf_app_settings_blogdescription" --quiet
fi
if [ ! -z "$conf_app_settings_date_format" ] ; then
    wp option update date_format $conf_app_settings_date_format --quiet
fi
if [ ! -z "$conf_app_settings_time_format" ] ; then
    wp option update time_format $conf_app_settings_time_format --quiet
fi
if [ ! -z "$conf_app_settings_timezone_string" ] ; then
    wp option update timezone_string $conf_app_settings_timezone_string --quiet
fi
if [ ! -z "$conf_app_settings_start_of_week" ] ; then
    wp option update start_of_week $conf_app_settings_start_of_week --quiet
fi
# Media
if [ ! -z "$conf_app_settings_large_size_h" ] ; then
    wp option update large_size_h $conf_app_settings_large_size_h --quiet
fi
if [ ! -z "$conf_app_settings_large_size_w" ] ; then
    wp option update large_size_w $conf_app_settings_large_size_w --quiet
fi
if [ ! -z "$conf_app_settings_medium_size_h" ] ; then
    wp option update medium_size_h $conf_app_settings_medium_size_h --quiet
fi
if [ ! -z "$conf_app_settings_medium_size_w" ] ; then
    wp option update medium_size_w $conf_app_settings_medium_size_w --quiet
fi
if [ ! -z "$conf_app_settings_thumbnail_crop" ] ; then
    wp option update thumbnail_crop $conf_app_settings_thumbnail_crop --quiet
fi
if [ ! -z "$conf_app_settings_thumbnail_size_h" ] ; then
    wp option update thumbnail_size_h $conf_app_settings_thumbnail_size_h --quiet
fi
if [ ! -z "$conf_app_settings_thumbnail_size_w" ] ; then
    wp option update thumbnail_size_w $conf_app_settings_thumbnail_size_w --quiet
fi
# Miscellaneous
if [ ! -z "$conf_app_settings_convert_smilies" ] ; then
    wp option update convert_smilies $conf_app_settings_convert_smilies --quiet
fi
if [ ! -z "$conf_app_settings_uploads_use_yearmonth_folders" ] ; then
    wp option update uploads_use_yearmonth_folders $conf_app_settings_uploads_use_yearmonth_folders --quiet
fi
# Permalinks
if [ ! -z "$conf_app_settings_permalink_structure" ] ; then
    wp rewrite structure "$conf_app_settings_permalink_structure" --quiet
fi
# Privacy
if [ ! -z "$conf_app_settings_blog_public" ] ; then
    wp option update blog_public $conf_app_settings_blog_public --quiet
fi
# Reading
if [ ! -z "$conf_app_settings_frontpage_name" ] && [ ! -z "$conf_app_settings_page_on_front" ]; then
    wp post create --post_type=page --post_title="$conf_app_settings_frontpage_name" --post_content='Front Page created by wp-pro.club' --post_status=publish --quiet
    wp option update page_on_front $(wp post list --post_type=page --post_status=publish --posts_per_page=1 --pagename="$conf_app_settings_frontpage_name" --field=ID --format=ids --allow-root) --quiet
fi
if [ ! -z "$conf_app_settings_show_on_front" ] ; then
    wp option update show_on_front $conf_app_settings_show_on_front --quiet
fi
