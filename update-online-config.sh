#!/bin/sh
down_dir="/tmp/online_rules"
mkdir -p $down_dir
echo "########################### start download files ###########################"
# download related files to tmp directory
fileList="direct-list proxy-list reject-list apple-cn google-cn gfw greatfire"
for filename in $fileList;
do
  newFilename=${filename//-/_}
  echo -e "\n downloading https://gcore.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/${newFilename}.txt ... \n"
  curl -C - --retry 10 https://gcore.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/${filename}.txt >> $down_dir/${newFilename}.txt
done
echo "########################### all files download successfully! ###########################"
