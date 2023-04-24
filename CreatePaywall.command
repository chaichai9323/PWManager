#!/bin/bash
filepath=$(cd "$(dirname "$0")"; pwd)

cd "$filepath"

read -p "请输入项目编号比如 OOG104 , AI101 等等... : " PROJECT
 
if [ -d "PWManager/Classes/Paywalls/$PROJECT" ]; then
  echo "项目已经存在，准备创建Paywall"
else
  mkdir "PWManager/Classes/Paywalls/$PROJECT"
  mkdir "PWManager/Assets/$PROJECT"
fi

PAYWALL=""
while true
do
  read -p "请输入Paywall ID: " PAYWALL
  if [ -f "PWManager/Classes/Paywalls/$PROJECT/Paywall_$PAYWALL.swift" ]; then
    echo "Paywall ID 已经存在"
    continue
  fi
  break;
done

PAYWALL=${PAYWALL//[^[:alnum:]]/_}

echo "开始创建Paywall"

cmds="s;template;$PAYWALL;"
swift="./PWManager/Classes/Paywalls/$PROJECT/Paywall_$PAYWALL.swift"

cat PWManager/Classes/Paywalls/Paywall_template.swift | sed $cmds >> $swift

cp -rf PWManager/Assets/template PWManager/Assets/$PROJECT/$PAYWALL

demostr="\ts.subspec \"$PROJECT/$PAYWALL\" do | view |\n 
  \t\tarr = view.name.split(\"/\")\n
  \t\tpaywallid = arr[arr.count - 1]\n
  \t\tview.source_files = \"#{dir}/Classes/Paywalls/*_#{paywallid}.swift\"\n
  \t\tview.resource_bundles = {\n
        \t\t\t\"#{s.name}_#{paywallid}\" => [\"#{dir}/Assets/#{paywallid}/*\"]\n
  \t\t}\n
  \t\tview.dependency \"SnapKit\"\n
  \tend\n\n\n
  \ts.default_subspec = \"rc\"\n\n
end
"

cat PWManager.podspec | sed "s/s.default_subspec.*//" | sed '$d' > tmp.txt
echo -e $demostr >> tmp.txt
cat tmp.txt > PWManager.podspec
rm -f tmp.txt
echo "创建Paywall完成,1秒后关闭终端";sleep 1;killall Terminal