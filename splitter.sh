#!bin/bash

if [ "$#" -le 1 ] || [ "$#" -gt 3 ] ; then
  printf "Invalid Args\n\tfile_name: file to be split\n\tfile_prefix: prefix of new files.\n\tlength: length of split files(default=10000)\n\n"
  exit

# if there's only two args then do default line amount
elif [ "$#" -eq 2 ]; then
  lines=10000

else
  let "lines=$3"

fi

# setting up variables and such
let "num_lines_in_file=$(cat $1 | wc -l)"
let "num_output_files=$(( num_lines_in_file / lines + 1 ))"
num_suffix=$(echo "l($num_output_files)/l(26)" | bc -l)
num_suffix=$(echo $num_suffix | awk '{print int($1+0.5)}')
let "num_suffix=num_suffix + 1"

file_ext=$(echo "$1"|awk -F . '{print $NF}')


rm -rf "$2_split" || return
mkdir "$2_split"
tail -n +2 $1 | split -l $lines -a $num_suffix - $2_
for file in $2_*
do
    if [ "$file" != "$2_split" ]; then
      head -n 1 $1 > tmp_file
      cat $file >> tmp_file
      mv -f tmp_file "$2_split/$file.$file_ext"
      rm -f $file
    fi
done
