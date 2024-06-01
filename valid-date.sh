#!/bin/bash
#인수는 많으면 반드시 3개만, 아니면 오류
if [ "$#" -ne 3 ]; then
    echo "입력값 오류"
    exit 1
fi
#년월일 분리
month_input=$1
date=$2
year=$3
#모두 소문자 변환후 대문자로 변환, 유효하지 않은 달 체크하기
month=$(echo "$month_input" | tr '[:upper:]' '[:lower:]')
case $month in
    jan|january|1) month="Jan" ;;
    feb|february|2) month="Feb" ;;
    mar|march|3) month="Mar" ;;
    apr|april|4) month="Apr" ;;
    may|5) month="May" ;;
    jun|june|6) month="Jun" ;;
    jul|july|7) month="Jul" ;;
    aug|august|8) month="Aug" ;;
    sep|september|9) month="Sep" ;;
    oct|october|10) month="Oct" ;;
    nov|november|11) month="Nov" ;;
    dec|december|12) month="Dec" ;;
    *)
        echo "$month_input은 유효하지 않은 달입니다."
        exit 1
        ;;
esac
#유효하지 않은 날짜, 연도 체크하기
if ! [[ "$date" =~ ^[0-9]+$ ]]; then
    echo "날짜는 숫자여야 합니다. $date는 유효하지 않습니다."
    exit 1
fi
if ! [[ "$year" =~ ^[0-9]+$ ]]; then
    echo "연도는 숫자여야 합니다. $year는 유효하지 않습니다."
    exit 1
fi
# 윤년체크하기
if (( year % 4 == 0 && year % 100 != 0 )) || (( year % 400 == 0 )); then
    is_leap=true
else
    is_leap=false
fi
#각 달의 일자처리
case $month in
    "Jan"|"Mar"|"May"|"Jul"|"Aug"|"Oct"|"Dec") max_days=31 ;;
    "Apr"|"Jun"|"Sep"|"Nov") max_days=30 ;;
    "Feb")
        if [ "$is_leap" == "true" ]; then
            max_days=29
        else
            max_days=28
        fi
        ;;
esac
# 마지막으로, 위 식의 max_days초과 시, 오류메시지 처리
if [ "$date" -gt "$max_days" ]; then
    echo "$month $date $year은 유효하지 않습니다. (이유: $month는 $max_days일까지 있습니다.)"
    exit 1
fi
# 유효하다면 문자 변환된 후로 출력
echo "$month $date $year"