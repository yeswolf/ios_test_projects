declare -A projects
declare -a result
declare -a all=(
   "openemu"
   "eidolon"
   "wire-ios"
   "wwdc"
   "wordpress-ios"
   "focus-ios"
   "alamofire"
   "onionbrowser"
   "signal-ios"
   "sequelpro"
   "cocoaconferences-swiftui"
   "xkcd"
)

projects[openemu,root]=openemu
projects[openemu,type]=hmm
projects[openemu,commands]=""

projects[eidolon,root]=artsy
projects[eidolon,type]=large
projects[eidolon,commands]='bundle install && bundle exec fastlane oss'

projects[wire-ios,root]=wireapp
projects[wire-ios,type]=large
projects[wire-ios,commands]='sh setup.sh'

projects[wwdc,root]=insidegui
projects[wwdc,type]=large
projects[wwdc,commands]='sh bootstrap.sh'

projects[wordpress-ios,root]=wordpress-mobile
projects[wordpress-ios,type]=large
projects[wordpress-ios,commands]='git checkout $(git describe --tags) && rake dependencies'

projects[focus-ios,root]=mozilla-mobile
projects[focus-ios,type]=large
projects[focus-ios,commands]='sh checkout.sh'

projects[alamofire,root]=alamofire
projects[alamofire,type]=medium
projects[alamofire,commands]='sh bootstrap.sh'

projects[onionbrowser,root]=onionbrowser
projects[onionbrowser,type]=medium
projects[onionbrowser,commands]='rm -rf Carthage/ && brew install automake libtool && git checkout 2.X && pod repo update && pod install && carthage update --platform iOS'

projects[signal-ios,root]=signalapp
projects[signal-ios,type]=medium
projects[signal-ios,commands]='gem install cocoapods-binary'

projects[sequelpro,root]=sequelpro
projects[sequelpro,type]=medium
projects[sequelpro,commands]=''

projects[cocoaconferences-swiftui,root]=yeswolf
projects[cocoaconferences-swiftui,type]=small
projects[cocoaconferences-swiftui,commands]='pod install'

projects[xkcd,root]=paulrehkugler
projects[xkcd,type]=small
projects[xkcd,commands]=''

if [ $# -ge 1 ]; then
  result=("${@[@]}")
fi
if [ $# -lt 1 ]; then
  result=("${all[@]}")
fi
for project in $result; do
  if [ ! -d ${projects[$project,type]}/$project ]; then
    git clone --recursive https://github.com/${projects[${project},root]}/"$project".git ${projects[$project,type]}/"$project"
    cd ${projects[$project,type]}/$project
    if [ ! -z "${projects[$project,commands]}" ]; then
      sh -c ${projects[$project,commands]}
    fi
    cd ../../
  else
    echo "Project $project already exist"
  fi
done


