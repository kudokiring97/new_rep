#!/bin/bash
#주요함수
# 지역번호 선언하기
declare -A area_codes=(
    ["02"]="서울"
    ["051"]="부산"
    ["053"]="대구"
    ["032"]="인천"
    ["062"]="광주"
)
filename="phone.txt"
name=$1
phone_number=$2
#인수는 프로그램 포함 반드시 2개만 설정
if [ "$#" -ne 2 ]; then
  echo "입력값 오류, 인수는 반드시 2개만을 입력하세요."
  exit 1
fi
#전화 번호 인수를 숫자로 제한하기
if ! [[ "$phone_number" =~ ^[0-9]+$ ]]; then
  echo "전화번호는 반드시 숫자로 입력하세요."
  exit 1
fi
#지역번호 추출 및 정리
if [[ ${phone_number:0:2} == "02" ]]; then
  phone_number="${phone_number:0:2}-${phone_number:2:4}-${phone_number:6:4}"
else  
  phone_number="${phone_number:0:3}-${phone_number:3:4}-${phone_number:7:4}"
fi
#패턴은 XX-XXXX-XXXX 형식으로 변경 아니면 XXX-XXXX-XXXX 등 모두 고려
pattern="^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$"
if ! [[ $phone_number =~ $pattern ]]; then
  echo "올바른 전화형식 번호가 아닙니다."
  exit 1
fi
#유효한 지역 번호인지 고려하기
area_code=${phone_number%%-*}
if [ -z "${area_codes[$area_code]}" ]; then
  echo "유효한 지역 번호가 아닙니다. 다시 확인 바랍니다."
  exit 1
fi
area="${area_codes[$area_code]}"
#전화번호부 검색하기
search_entry=$(grep "^$name " "$filename")
#전화번호가 있다면? -> 이미 등록된 번호, 동일 번호 존재여부 확인
if [ -n "$search_entry" ]; then
  search_phone=$(echo "$search_entry" | cut -d' ' -f2)
  search_area_code=$(echo "$search_entry" | cut -d' ' -f3)
  if [ "$search_phone" == "$phone_number" ] && [ "$search_area_code" == "$area" ]; then
    echo "등록된 번호입니다.."
    exit 1
  else
    echo "등록된 번호가 존재하지 않습니다. 새로운 번호로 등록합니다."
    #새로운 번호 추가하기
    echo "$name $phone_number $area" >> "$filename"
    # 이름 순으로 정렬
    sort -o "$filename" "$filename"
  fi
#전화번호가 없다면? 추가하기
else
  echo "$name $phone_number $area" >> "$filename"
fi


