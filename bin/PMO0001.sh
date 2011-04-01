#!/bin/sh

RAILS_ENV=development
LOADER_CLASS=DetailScheduleLoader

while getopts "v" flag; do
  case $flag in
    \?) OPT_ERROR=1; break;;
    v) opt_verbose=true;;
  esac
done

shift $(( $OPTIND - 1 ))

if [ $OPT_ERROR ]; then
  echo >&2 "usage: $0 [-v] file.cvs"
  exit 1
fi

bundle exec rails runner -e $RAILS_ENV $LOADER_CLASS.load_file\(\'$@\'\)