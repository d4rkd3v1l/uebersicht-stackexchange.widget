#!/bin/sh
source "stackexchange.widget/config.sh"

# Widget setup
key="1e3*zfKz8dF5wvGmA9MhKQ(("
baseURI="https://api.stackexchange.com/2.2"
meURI="me?filter=!)69PCU5SMBXFAHf.D2hsloXb*w5W"
reputationURI="me/reputation?filter=!)sYX)Ef.6_GJKms(IoAV"
lastBadgeURI="me/badges?order=desc&sort=awarded&pagesize=1"

function GetResponse
{
	echo $(curl -sb -H --compressed "$baseURI/$1&site=$site&key=$key&access_token=$token")
}

response="{
	\"site\":\"$site\",
	\"me\":$(GetResponse $meURI),
	\"reputation\":$(GetResponse $reputationURI),
	\"lastBadge\":$(GetResponse $lastBadgeURI)
}"
echo "$response"
