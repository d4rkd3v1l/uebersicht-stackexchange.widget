#!/bin/sh
source "stackexchange.widget/config.sh"

# Widget setup
key="1e3*zfKz8dF5wvGmA9MhKQ(("
baseURI="https://api.stackexchange.com/2.2"
meURI="me?filter=!)69PCU5SMBXFAHf.D2hsloXb*w5W"
inboxUnreadURI="me/inbox/unread?filter=!w*zxrrVBf(gYloI6ki"
notificationsUnreadURI="me/notifications/unread?filter=!.UDUM4nLGqzSHDZi"
reputationURI="me/reputation?filter=!)sYX)Ef.6_GJKms(IoAV"
lastBadgeURI="me/badges?order=desc&sort=awarded&pagesize=1"

function GetResponse
{
	echo $(curl -sb -H --compressed "$baseURI/$1&site=$site&key=$key&access_token=$token")
}

response="{
	\"me\":$(GetResponse $meURI),
	\"inboxUnread\":$(GetResponse $inboxUnreadURI),
	\"notificationsUnread\":$(GetResponse $notificationsUnreadURI),
	\"reputation\":$(GetResponse $reputationURI),
	\"lastBadge\":$(GetResponse $lastBadgeURI)
}"
echo "$response"
