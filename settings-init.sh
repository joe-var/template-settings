#!/bin/bash

# WPI Settings
# by DimaMinka (https://dima.mk)
# https://github.com/wpi-pw/app

# Get config files and put to array
wpi_confs=()
for ymls in wpi-config/*
do
  wpi_confs+=("$ymls")
done

# Get wpi-source for yml parsing, noroot, errors etc
source <(curl -s https://raw.githubusercontent.com/wpi-pw/template-workflow/master/wpi-source.sh)

cur_env=$1
cur_wpi="wpi_env_${cur_env}_"

printf "${GRN}=======================${NC}\n"
printf "${GRN}Running settings script${NC}\n"
printf "${GRN}=======================${NC}\n"

## User
if [ ! -z "$(wpi_key "app_host")" ] && [ ! -z "$wpi_settings_admin_email" ] && [ ! -z "$wpi_settings_admin_password" ] && [ ! -z "$wpi_settings_admin_user" ] ; then
    wp core install --url="$(wpi_key "app_host")" --title="$wpi_settings_blogdescription" --admin_user="$wpi_settings_admin_user" --admin_password="$wpi_settings_admin_password" --admin_email="$wpi_settings_admin_email" --quiet
fi
if [ ! -z "$wpi_settings_first_name" ] && [ ! -z "$wpi_settings_last_name" ] ; then
    wp user update 1 --first_name=$wpi_settings_first_name --last_name=$wpi_settings_last_name --quiet
fi
# Discussion
if [ ! -z "$wpi_settings_comment_moderation" ] ; then
    wp option update comment_moderation $wpi_settings_comment_moderation --quiet
fi
if [ ! -z "$wpi_settings_comment_registration" ] ; then
    wp option update comment_registration $wpi_settings_comment_registration --quiet
fi
if [ ! -z "$wpi_settings_default_comment_status" ] ; then
    wp option update default_comment_status $wpi_settings_default_comment_status --quiet
fi
if [ ! -z "$wpi_settings_default_pingback_flag" ] ; then
    wp option update default_pingback_flag $wpi_settings_default_pingback_flag --quiet
fi
if [ ! -z "$wpi_settings_default_ping_status" ] ; then
    wp option update default_ping_status $wpi_settings_default_ping_status --quiet
fi
# General
if [ ! -z "$wpi_settings_blogdescription" ] ; then
    wp option update blogdescription "$wpi_settings_blogdescription" --quiet
fi
if [ ! -z "$wpi_settings_date_format" ] ; then
    wp option update date_format $wpi_settings_date_format --quiet
fi
if [ ! -z "$wpi_settings_time_format" ] ; then
    wp option update time_format $wpi_settings_time_format --quiet
fi
if [ ! -z "$wpi_settings_timezone_string" ] ; then
    wp option update timezone_string $wpi_settings_timezone_string --quiet
fi
if [ ! -z "$wpi_settings_start_of_week" ] ; then
    wp option update start_of_week $wpi_settings_start_of_week --quiet
fi
if [ ! -z "$wpi_settings_site_switch_language" ] ; then
    wp core language install $wpi_settings_site_switch_language --quiet
    wp site switch-language $wpi_settings_site_switch_language --quiet
fi
# Media
if [ ! -z "$wpi_settings_large_size_h" ] ; then
    wp option update large_size_h $wpi_settings_large_size_h --quiet
fi
if [ ! -z "$wpi_settings_large_size_w" ] ; then
    wp option update large_size_w $wpi_settings_large_size_w --quiet
fi
if [ ! -z "$wpi_settings_medium_size_h" ] ; then
    wp option update medium_size_h $wpi_settings_medium_size_h --quiet
fi
if [ ! -z "$wpi_settings_medium_size_w" ] ; then
    wp option update medium_size_w $wpi_settings_medium_size_w --quiet
fi
if [ ! -z "$wpi_settings_thumbnail_crop" ] ; then
    wp option update thumbnail_crop $wpi_settings_thumbnail_crop --quiet
fi
if [ ! -z "$wpi_settings_thumbnail_size_h" ] ; then
    wp option update thumbnail_size_h $wpi_settings_thumbnail_size_h --quiet
fi
if [ ! -z "$wpi_settings_thumbnail_size_w" ] ; then
    wp option update thumbnail_size_w $wpi_settings_thumbnail_size_w --quiet
fi
# Miscellaneous
if [ ! -z "$wpi_settings_convert_smilies" ] ; then
    wp option update convert_smilies $wpi_settings_convert_smilies --quiet
fi
if [ ! -z "$wpi_settings_uploads_use_yearmonth_folders" ] ; then
    wp option update uploads_use_yearmonth_folders $wpi_settings_uploads_use_yearmonth_folders --quiet
fi
# Permalinks
if [ ! -z "$wpi_settings_permalink_structure" ] ; then
    wp rewrite structure "$wpi_settings_permalink_structure" --quiet
fi
# Privacy
if [ ! -z "$wpi_settings_blog_public" ] ; then
    wp option update blog_public $wpi_settings_blog_public --quiet
fi
# Reading
if [ ! -z "$wpi_settings_frontpage_name" ] && [ ! -z "$wpi_settings_page_on_front" ]; then
    wp post create --post_type=page --post_title="$wpi_settings_frontpage_name" --post_content='Front Page created by wp-pro.club' --post_status=publish --quiet
    wp option update page_on_front $(wp post list --post_type=page --post_status=publish --posts_per_page=1 --pagename="$wpi_settings_frontpage_name" --field=ID --format=ids --allow-root) --quiet
fi
if [ ! -z "$wpi_settings_show_on_front" ] ; then
    wp option update show_on_front $wpi_settings_show_on_front --quiet
fi

# Extra settings
wp post delete 1 2 --force --quiet
wp widget reset --all --quiet
wp plugin uninstall hello --quiet

# Set Settings init to false after setup
sed -i "s/\bsettings: true\b/settings: false/g" ${PWD}/wpi-config/01-init.yml
