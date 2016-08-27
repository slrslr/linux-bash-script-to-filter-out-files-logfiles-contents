echo "1/5 - Enter directory containing files which contents we need to examine/filter out. Example directory (cpanel access logs: /home/cpuserhere/access-logs). No trailing slash!:"
read logdir

echo "2/5 - Enter pattern that have to be found in that files. Todays date: $(date). Example pattern: 27/Aug/2016:07"
read mustcontain

includeonlyloglinescontaining=".php"
echo "3/5 - Further display only lines containing following phrasses: (example: .php|php5|POST) hit enter to use \".php\" only"
read includeonlyloglinescontaininginput
if [ "$includeonlyloglinescontaininginput" != "" ];then
includeonlyloglinescontaining="$includeonlyloglinescontaininginput"
fi

excludeloglinescontaining="viewtopic|viewforum|memberlist|wp-comments|prev|html|404 |403 |wp-login.php|wp-cron.php"
echo "4/5 - Further hide lines containing following phrasses: (example: $excludeloglinescontaining) hit enter to use example phrasses"
read excludeloglinescontaininginput
if [ "$excludeloglinescontaininginput" != "" ];then
excludeloglinescontaining="$excludeloglinescontaininginput"
fi

echo -e "5/5 - We are prepared to find $logdir files containing $mustcontain and then filter out these files contents to show lines containing $mustcontain and \"$includeonlyloglinescontaining\" and exclude lines containing: $excludeloglinescontaining\nHit any key to continue"
read continue

for file in $(grep -Ril "$mustcontain" $logdir);do echo -e "\n$file" && cat $file|grep "$mustcontain"|grep -E "$includeonlyloglinescontaining"|grep -vE "$excludeloglinescontaining";done
