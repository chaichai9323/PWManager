#!/bin/bash
filepath=$(cd "$(dirname "$0")"; pwd)

cd "$filepath"

PROJECT=""
while true 
do
  echo -e "\033[35m请输入项目编号比如 OOG104 , AI101 等等... \033[0m"; read -p "" PROJECT
PROJECT=$(echo $PROJECT | tr 'a-z' 'A-Z')
if [[ $PROJECT =~ [A-Z]+[0-9]+ ]]; then
  break;
else
  echo -e "\033[31m 不符合(字母+数字)的项目命名规范，可以使用类似 \033[0m""\033[32m OOG101, OOG104 ... \033[0m"
fi
done

if [ -d "PWManager/Classes/Paywalls/$PROJECT" ]; then
  echo -e "\033[32m项目已经存在，准备创建Paywall\033[0m"
else
  echo -e "\033[32m开始创建项目\033[0m"
  mkdir "PWManager/Classes/Paywalls/$PROJECT"
  mkdir "PWManager/Assets/$PROJECT"
fi

PAYWALL=""
while true
do
  echo -e "\033[35m请输入Paywall ID,类似这样的 \033[0m""\033[32m u8enjsbh, u8enjsbh-01 ... \033[0m"
  read -p "" PAYWALL
  if [ -d "PWManager/Classes/Paywalls/$PROJECT/$PAYWALL" ]; then
    echo -e "\033[31mPaywall ID 已经存在\033[0m"
    continue
  fi
  break;
done

PAYWALL=${PAYWALL//[^[:alnum:]]/_}
classname=$PROJECT"_"$PAYWALL
cmds="s;Paywall_template;$classname;"
swift="./PWManager/Classes/Paywalls/$PROJECT/$PAYWALL/$classname.swift"

cp -rf PWManager/Assets/template PWManager/Assets/$PROJECT/$PAYWALL
cp -rf PWManager/Classes/Paywalls/template PWManager/Classes/Paywalls/$PROJECT/$PAYWALL
rm -f PWManager/Classes/Paywalls/$PROJECT/$PAYWALL/*.swift
cat PWManager/Classes/Paywalls/template/Paywall_template.swift | sed $cmds > $swift


echo -e "\033[32m创建Paywall完成\033[0m"

cd "Example"

pod install

echo "1秒后关闭终端"; sleep 1; killall Terminal