declare -a result
readonly NAME=0
readonly ROOT=1
readonly TYPE=2
readonly COMMANDS=3

projects=(
  openemu openemu hmm ''
  eidolon artsy large 'bundle install && bundle exec fastlane oss'
  wire-ios wireapp large 'sh setup.sh'
  wwdc insidegui large 'sh bootstrap.sh'
  wordpress-ios wordpress-mobile large 'git checkout $(git describe --tags) && rake dependencies'
  focus-ios mozilla-mobile large 'sh checkout.sh'
  alamofire alamofire medium 'sh bootstrap.sh'
  onionbrowser onionbrowser medium 'rm -rf Carthage/ && brew install automake libtool && git checkout 2.X && pod repo update && pod install && carthage update --platform iOS'
  signal-ios signalapp medium 'gem install cocoapods-binary'
  sequelpro sequelpro medium ''
  cocoaconferences-swiftui yeswolf small 'pod install'
  xkcd paulrehkugler small ''
)

if [ $# -ge 1 ]; then
  result=( "$@" )
fi

if [ $# -lt 1 ]; then
  count=${#projects[*]}
  for (( i=0; i <= $count; i+=4 ))
  do
    result+=(${projects[$i]})
  done
fi
for project in ${result[*]}
do
  project_start_idx=0
  count=${#projects[*]}
  for (( i=0; i < $count; i+=1 ))
  do
    if [ "${projects[$i]}" == "$project" ]; then
      project_start_idx=$i
      break
    fi
  done
  project_root=${projects[$project_start_idx+$ROOT]}
  project_commands=${projects[$project_start_idx+$COMMANDS]}
  project_type=${projects[$project_start_idx+$TYPE]}
  subdir="$project_type/$project"
  if [ ! -d $subdir ]; then
      git clone --recursive "https://github.com/$project_root/$project".git $subdir
      cd $subdir
      if [ ! -z "$project_commands" ]; then
        eval ${project_commands}
      fi
      cd ../../
  else
   echo "Project $project already exist"
  fi
done