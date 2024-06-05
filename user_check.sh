#!/bin/bash
if [ "$#" -ne 1 ]; then
  echo "사용법: $0 <로그인 확인할 유저 이름>"
  exit 1
fi
user="$1"
while true;
 do
 if who | grep -q "$user"
 then
   echo "$user 로그인함!"
 fi
 sleep 60
done