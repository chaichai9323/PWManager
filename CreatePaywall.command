#!/bin/bash
filepath=$(cd "$(dirname "$0")"; pwd)

cd "$filepath"

PROJECT=""
while true 
do
read -p "请输入项目编号比如 OOG104 , AI101 等等... : " PROJECT
PROJECT=$(echo $PROJECT | tr 'a-z' 'A-Z')
if [[ $PROJECT =~ [A-Z]+[0-9]+ ]]; then
  break;
else
  echo "不符合(字母+数字)的项目命名规范，可以使用类似 OOG101, OOG104 ..."
fi
done

if [ -d "PWManager/Classes/Paywalls/$PROJECT" ]; then
  echo "项目已经存在，准备创建Paywall"
else
  echo "开始创建项目"
  mkdir "PWManager/Classes/Paywalls/$PROJECT"
  mkdir "PWManager/Assets/$PROJECT"
fi

PAYWALL=""
while true
do
  read -p "请输入Paywall ID: " PAYWALL
  if [ -f "PWManager/Classes/Paywalls/$PROJECT/$PROJECT_$PAYWALL.swift" ]; then
    echo "Paywall ID 已经存在"
    continue
  fi
  break;
done

PAYWALL=${PAYWALL//[^[:alnum:]]/_}
classname=$PROJECT"_"$PAYWALL
cmds="s;Paywall_template;$classname;"
swift="./PWManager/Classes/Paywalls/$PROJECT/$classname.swift"

cat PWManager/Classes/Paywalls/Paywall_template.swift | sed $cmds > $swift

cp -rf PWManager/Assets/template PWManager/Assets/$PROJECT/$PAYWALL

echo "创建Paywall完成"

cd "Example"

pod install

echo "1秒后关闭终端"; sleep 1; killall Terminal