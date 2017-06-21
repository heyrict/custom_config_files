# sl == ls
alias sl="ls"

# using c++11
alias g++='g++ -std=c++11'

# pandoc template
#alias pandoc2chspdf="pandoc --template=$HOME/模板/chs_template.tex --latex-engine=xelatex -M CJKmainfont:文泉驿微米黑 --biblio $HOME/Tex/MyRef.bib" 
alias pandoc="pandoc --filter pandoc-tablenos"
alias pandoc2chs="pandoc --latex-engine=xelatex -M CJKmainfont:文泉驿微米黑 --biblio $HOME/Tex/MyRef.bib" 
alias pandoc2chspdf="pandoc2chs --template=$HOME/.pandoc/default.latex ~/pandoc_markdown/CHS_METADATA.yaml"
eval "$(pandoc --bash-completion)"

# often-use programs
alias html2text="~/Eric/Program_Files/html2text/html2text.py"
alias 2048="~/Eric/Program_Files/2048/2048"
export PATH=$PATH:~/Eric/MyPrograms/bin

# fbterm preference
alias white_fontcolor="echo -en \"\e]P7ffffff\""
alias default_fontcolor="echo -en \"\e]R\""

# battery preference
battery_usage(){ echo $(cat /sys/class/power_supply/BAT1/capacity)%;}
battery_indicator(){
 local indent='5m'
 if [[ $# > 0 ]]
 then
  indent=$1
 fi
 while true
 do
  clear
  battery_usage
  sleep $indent
 done 
}

# octave preference
alias octave="octave --no-gui"

# rm-protect
alias cp="cp -i"
alias rm="rm-p"

# ppsspp savedata control
alias sync_psp_data_from_Lenovo="\cp -uvr /media/ericx/LENOVO/Eric/psp/memstick/PSP/SAVEDATA/* ~/.config/ppsspp/PSP/SAVEDATA"
alias sync_psp_data_to_Lenovo="\cp -uvr ~/.config/ppsspp/PSP/SAVEDATA /media/ericx/LENOVO/Eric/psp/memstick/PSP/SAVEDATA/*"

# pipe dict to less
d(){ dict $* | less; }

# cd to specified directories
alias wd="cd /home/ericx/Eric/MyPrograms"

excute_program_in_specific_dir(){
local curdir=$(pwd)
cd $2
./$1 ${@:3}
cd $curdir
}

# temporary custom programs
alias revise="excute_program_in_specific_dir revise.py /home/ericx/Eric/MyPrograms/exam/revise"
alias SysAna="excute_program_in_specific_dir sysana.py /home/ericx/Eric/MyPrograms/exam/SysAna"
alias Sat6="excute_program_in_specific_dir engmain.py /home/ericx/Eric/MyPrograms/exam/English_words"

alias zotero="excute_program_in_specific_dir zotero /opt/Zotero_linux-x86_64"

xmind(){
local OPTIND
while getopts it opt
do
  case "$opt" in
    i) local Interactive=1;;
    t) local Interactive=1;;
  esac
done
shift $[ $OPTIND - 1 ]

if [ ! $Interactive ]; then local Interactive=0; fi

local curdir=$(pwd)
cd /opt/XMind/XMind_amd64/
if [ $# = 0 ]
then
  if [ $Interactive = 0 ]
    then ./XMind
  else find -name '*.xmind'
  fi
else
 local all=""
 for word in $*
 do
   all=$all"_"$word
 done
 echo "-----------------"
 local found=($(find -name '*.xmind' | grep ".*/${all:1}[^/]*$"))
 if [ ${#found[@]} = 1 ] ; then 
   echo "One File Found."
   echo ${found[0]}
   echo "-----------------"
   if [ $Interactive = 0 ]; then 
     ./XMind ${found[0]}
   fi
 elif [ ${#found[@]} = 0 ]; then 
   echo "No matching file found. Exit."
   echo "-----------------"
 else
   echo "More than one file found."
   for ((i = 0 ; i < ${#found[@]} ; ++i )); do
     echo -e "$i\t${found[$i]}"
   done
   echo "-----------------"
   if [ $Interactive = 0 ]; then 
     local choose
     read -p "Which one to choose? " choose
     if [[ $choose < ${#found[@]} ]]; then
     ./XMind ${found[$choose]}
     fi
   fi
   echo
 fi
fi
cd $curdir
return 0
}


# run splash in docker
splash(){
sudo docker stop c4
sudo docker run -p 8050:8050 scrapinghub/splash
}

# paper search engine
alias webofscience="firefox http://apps.webofknowledge.com/"
alias sciencedirect="firefox http://www.sciencedirect.com/"
pubmed(){
if test $# -eq 0
then
    firefox https://www.ncbi.nlm.nih.gov/pubmed
else
    local str=""
    for i in $*;do str=$str"+"$i;done
    firefox https://www.ncbi.nlm.nih.gov/pubmed?term=${str:1}
fi
}

ncbi(){
if test $# -eq 0
then
    firefox https://www.ncbi.nlm.nih.gov/
else
    local str=""
    for i in $*;do str=$str"+"$i;done
    firefox https://www.ncbi.nlm.nih.gov/gquery/?term=${str:1}
fi
}

nature(){
if test $# -eq 0
then
    firefox https://www.nature.com/
else
    local str=""
    for i in $*;do str=$str"+"$i;done
    firefox https://www.nature.com/search?q=${str:1}
fi
}

wanfang(){
if test $# -eq 0
then
    firefox http://s.g.wanfangdata.com.cn
else
    local str=""
    for i in $*;do str=$str"+"$i;done
    firefox http://s.g.wanfangdata.com.cn/Paper.aspx?q=${str:1}
fi
}

# color palettes
color_palette(){
    for i in {0..255}
    do
        echo -en "\e[38;5;${i}mc${i}\e[0m\t"
        if [ $[${i} % 16] = 15 ]
        then
            echo
        fi
    done
    echo
}

# brightness
brightness(){
    if [ $# = 0 ]
    then
        cat /sys/class/backlight/intel_backlight/brightness
    fi
}
