#!/bin/bash
export WS_ROOT=$HOME/ros2_ws

## ros2cd: complete package name by "Tab" key
function ros2cd () {
  dir_path="${WS_ROOT}/src/"
  dirs=`find $dir_path -type f -name package.xml` #search directoried with package.xml
  pkgs_dir=`dirname $dirs`
  pkgs_dir_array=(`echo $pkgs_dir`) #array of paths to all packages
  pkgs_name=`for pkg in $pkgs_dir; do grep "<name>" $pkg/package.xml | awk -F "</name>" '{ print $1}'| awk -F "<name>" '{ print $NF}' ; done` 
  pkgs_name_array=(`echo $pkgs_name`) #array of package names at workspace
  input_pkg_name=`echo ${1} | awk -F "/" '{ print $1}'` #get 1st column devide by "/"
  column_num=`echo ${1} | awk -F '/' '{print NF}'` #get number of columns
  pkg_sub_dir=`if test $column_num -gt 1 ; then echo ${1} | cut -d "/" -f 2- ; fi` #get name of sub-directory if columns number is over 2
  for i in ${!pkgs_name_array[@]}; do if [[ ${pkgs_name_array[$i]} = $input_pkg_name ]]; then cd ${pkgs_dir_array[$i]}/$pkg_sub_dir ; fi done #move to pkg_name/sub-dir
  unset $pkg $dir_path $dirs $pkgs_dir $pkgs_dir_array $pkgs_name $input_pkg_name $column_num $pkg_sub_dir
}
_pkg_name_sub_directory_complete() {
  local cur prev opts
  _get_comp_words_by_ref -n : cur prev
  opts=${pkgs_name_array[@]}
  COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
  #sub-directory is NOT completed now. COMING SOON...?
}
complete -o nospace -F _pkg_name_sub_directory_complete ros2cd 
alias ros2cd="ros2cd"
ros2cd

## cb: build all packages in your workspace
alias cb='cd $WS_ROOT && colcon build --symlink-install'

## cbp [pkg_name]: build only selected package,complete package name by "Tab" key
alias cbp='cd $WS_ROOT && colcon build --symlink-install --packages-select'

_pkg_name_complete() {
  local cur prev opts
  _get_comp_words_by_ref -n : cur prev
  opts=${pkgs_name_array[@]}
  COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
}
complete -o nospace -F _pkg_name_complete cbp
