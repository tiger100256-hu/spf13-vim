#!/bin/sh
usage()
{
   echo "usage : makecscope src_path project_name"
   echo "I will create gtags db in ~/gtags/project_name"
}
if [ $# -ne 2 ]
then
    usage
    exit
fi
SRC_PATH="$(realpath $1)"
GTAG_PATH=~/gtags/$2
export PATH=$PATH:/usr/local/bin

mkdir -p $GTAG_PATH
cd $GTAG_PATH
find $SRC_PATH -name "*.h" -o -name "*.hpp" -o -name "*.c" -o -name "*.cpp" -o -name "CMakeList.txt" -o -name "*.cmake" > gtags.files
find $SRC_PATH -type d -name "include"  > ~/.syntastic_cpp_config
find $SRC_PATH -name "*.h" -o -name "*.hpp" | xargs dirname >> ~/.syntastic_cpp_config
sort ~/.syntastic_cpp_config | uniq > ~/.syntastic_cpp_config_tmp
sed  's/^/-I/' ~/.syntastic_cpp_config_tmp > ~/.syntastic_cpp_config
cd $SRC_PATH
export GTAGSFORCECPP=1
gtags -i -f $GTAG_PATH/gtags.files $GTAG_PATH

