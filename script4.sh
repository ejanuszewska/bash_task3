Skip to content
Features Business Explore Marketplace Pricing
This repository
Search
Sign in or Sign up
 Watch 1  Star 0  Fork 0 ejanuszewska/bash_task3
 Code  Issues 0  Pull requests 0  Projects 0 Insights 
Branch: details Find file Copy pathbash_task3/script4.sh
5c4ceb4  17 hours ago
@ejanuszewska ejanuszewska report2
1 contributor
RawBlameHistory     
Executable File  47 lines (38 sloc)  1.04 KB
#!/bin/bash

clear
cd /home/ewa/bash_task3/

git checkout details
hash=$(git rev-parse HEAD)
git checkout summary
git cherry-pick $hash
#git push origin summary
git checkout details

CPULOADS=()
MEMLOAD=()
fileCat=$(git show HEAD:systemstats3.xml)
#echo $fileCat
CPULOADS+=$(echo "$fileCat" | sed -n '/<cpuload>/,/<\/cpuload>/p')
MEMLOADS+=$(echo "$fileCat" | sed -n '/<memload>/,/<\/memload>/p')

for(( i=1; i<5; i++))
do
fileCat=$(git show HEAD~$i:systemstats3.xml)
CPULOADS+=$(echo "$fileCat" | sed -n '/<cpuload>/,/<\/cpuload>/p')
MEMLOADS+=$(echo "$fileCat" | sed -n '/<memload>/,/<\/memload>/p')
done

CPULOADSAVERAGE=CPULOADS/5
MEMLOADSAVERAGE=MEMLOADS/5

xml=$(cat average.xml)

DATE=$(date +%Y-%m-%d)
WEEKDAY=$(date +%u)
TIME=$(date +"%T")
xml=${xml/<date>/<date>$DATE}
xml=${xml/<weekday>/<weekday>$WEEKDAY}
xml=${xml/<time>/<time>$TIME}
xml=${xml/<cpuload>/<cpuload>$CPULOADSAVERAGE}
xml=${xml/<memload>/<memload>$MEMLOADSAVERAGE}

echo $xml > average3.xml
git checkout summary
git add .
git commit --amend 
git push origin summary
git checkout details
Contact GitHub API Training Shop Blog About
© 2017 GitHub, Inc. Terms Privacy Security Status Help
