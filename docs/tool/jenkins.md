# jenkins 部署辅助
BUILD_VERSION 
${BUILD_DATE_FORMATTED, "yyyyMMdd"}${BUILDS_TODAY}
UNSTABLE

vim start.sh
```
#/bin/sh
path=/home/lambert/testgit
cd /home/lambert/.jenkins/workspace/test-dev
git reflog |awk '{print $6,$8}'|head -1 |xargs git diff |grep '\-\-\- a/\|+++ b/' | awk '{print $2}' > $path/test.txt
sed -i 's/-po//g' $path/test.txt
sed -i 's/-fa//g' $path/test.txt
sed -i 's/-repo//g' $path/test.txt
sed -i 's/pent//g' $path/test.txt
sed -i 's/static//g' $path/test.txt

cut -d \/ -f 2 $path/test.txt > $path/project.txt
awk '!x[$0]++' $path/project.txt > $path/env.txt
sed -i 's/-v1//g' $path/env.txt
sed -i 's/-/_/g' $path/env.txt
#cat /root/docker/env.txt | while read LINE
#do
#  echo $LINE
#  if [ -n "$LINE" ]; then
#    sed -ie '/'$LINE'/d' /root/docker/.env
#    echo tag_$LINE=$1  >> /root/docker/.env
#  fi
#done
#rm -rf /root/docker/env.txt

sshpass -p 'passwork' scp -r $path/env.txt root@xxx.xxx.xxx.xxx:/root/docker
```
