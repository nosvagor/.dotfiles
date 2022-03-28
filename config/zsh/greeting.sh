#!/usr/bin/env bash

###############################################################################
# Author: cullyn
# Date Created: March, 25 2022
# Last Modified: March, 25 2022

# Description:
# Custom DNA shell greeter, responds to terminal width (poorly)

# Usage:
# call script on load (.zshrc)
###############################################################################


a='\033[0;31m' # red |
t='\033[0;32m' # green |
c='\033[0;33m' # orange |
g='\033[0;34m' # blue |
w='\033[0m' # white |

l='\033[0m⨓' # white \
r='\033[0m༽' # white /

cols=$(tput cols)
entry_num=$(( (${cols} / 2) + (${cols} / 10) + (${cols} / 16) - 3*(${cols} / 75) - 2*(${cols} / 100) ))
entries=($(shuf -r -i 0-3 -n "$entry_num"))
fp=()
tp=()
#       red 0  grn 1    blu 2   yel 3
bases=(${a}"|" ${t}"|" ${c}"|" ${g}"|")
okazaki=1
okazaki_frag () {

    base=${entries[$1]}

    case $base in
        0 )
            tp+=(${bases[1]}) # red -> green
            ;;
        1 )
            tp+=(${bases[0]}) # green -> red
            ;;
        2 )
            tp+=(${bases[3]}) # blue -> orange
            ;;
        3 )
            tp+=(${bases[2]}) # orange -> blue
            ;;
    esac
}

for (( i = 0; i < ${#entries[@]}; i++ )); do

    e=${entries[$i]}

    fp+=(${bases[$e]})

    case $okazaki in
        1 )
            okazaki_frag $i
            (( okazaki++ ))
            ;;
        2 )
            okazaki_frag $i
            (( okazaki++ ))
            ;;
        3 )
            okazaki_frag $(( $i + 2 ))
            (( okazaki++ ))
            ;;
        4 )
            okazaki_frag $(( $i + 2 ))
            (( okazaki++ ))
            ;;
        5 )
            okazaki_frag $(( $i - 2 ))
            (( okazaki++ ))
            ;;
        6 )
            okazaki_frag $(( $i - 2 ))
            okazaki=1
            ;;
    esac
done

s1=' '
s1=' '
s2='  '
top_chars=(𝁚 𝀢 𝀕)
bot_chars=(𝀾  ' ' 𝁖)

for (( i = 0; i < ${entry_num}; i++ )); do
    top=$top${top_chars[$(( $i % 3 ))]}
    base1=$base1${fp[$i]}
    base2=$base2${tp[$i]}
    bot=$bot${bot_chars[$(( $i % 3 ))]}

    if [[ $((${i} % 6 )) -eq 1 ]]; then
        base2=$base2${l}${s1}
        bot=$bot${s2}
    fi

    if [[ $((${i} % 3 )) -eq 2 ]]; then
        base1=$base1${r}
        top=$top${s1}
    fi

    if [[ $((${i} % 6 )) -eq 5 ]]; then
        base1=$base1${s1}${l}
        top=$top${s2}
    fi

    if [[ $((${i} % 3 )) -eq 1 ]]; then
        base2=$base2${r}
        bot=$bot${s1}
    fi
done


echo

if [[ $cols -eq 246 ]]; then
    echo -e "${top:0:$(( ${#top} ))}"
    echo -e "${base1:0:$(( ${#base1} ))}"
    echo -e "${base2:0:$(( ${#base2} - 12 ))}${w}"
    echo -e "${bot:0:$(( ${#bot} - 3 ))}"
elif [[ $cols -eq 291 ]]; then
    echo -e "${top:0:92}"
    echo -e "${base1:0:845}"
    echo -e "${base2:0:845}${w}"
    echo -e "${bot:0:91}"
elif [[ $cols -eq 92 ]]; then
    echo -e "${top:0:$(( ${#top} - 2 ))}"
    echo -e "${base1:0:$(( ${#base1} - 12 ))}"
    echo -e "${base2:0:$(( ${#base2} - 12 ))}${w}"
    echo -e "${bot:0:$(( ${#bot} - 5 ))}"
elif [[ $cols -lt 92 && $cols -gt 40 ]]; then
    echo -e "${top:0:$(( ${#top} - 2 ))}"
    echo -e "${base1:0:$(( ${#base1} - 12 ))}"
    echo -e "${base2:0:$(( ${#base2} - 12 ))}${w}"
    echo -e "${bot:0:$(( ${#bot} - 5 ))}"
else
    echo -e "${top:0:36}"
    echo -e "${base1:0:350}"
    echo -e "${base2:0:340}${w}"
    echo -e "${bot:0:36}"
fi
