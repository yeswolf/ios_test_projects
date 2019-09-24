#Hmmm...
git clone --recursive https://github.com/OpenEmu/OpenEmu.git Hmm/OpenEmu

#Large
git clone https://github.com/artsy/eidolon.git Large/eidolon
cd Large/eidolon
bundle install
bundle exec fastlane oss
cd ../../

git clone https://github.com/insidegui/WWDC Large/WWDC
cd Large/WWDC
./boostrap.sh
cd ../../

git clone https://github.com/wordpress-mobile/WordPress-iOS.git Large/Wordpress
cd Large/WordPress
rake dependencies
cd ../../

git clone https://github.com/mozilla-mobile/focus-ios.git Large/focus-ios
cd Large/focus-ios
./checkout.sh
cd ../../

git clone --recursive https://github.com/peter-iakovlev/Telegram-iOS.git Large/Telegram

#Middle
git clone https://github.com/Alamofire/Alamofire.git Middle/Alamofire

git clone https://github.com/OnionBrowser/OnionBrowser Middle/OnionBrowser
cd Middle/OnionBrowser
rm -rf Carthage/
brew install automake libtool
git checkout 2.X
pod repo update
pod install
carthage update --platform iOS
cd ../../

git clone https://github.com/vector-im/riot-ios.git Middle/Riot
cd Middle/Riot
bundle install
bundle exec pod install
cd ../../

git clone https://github.com/signalapp/Signal-iOS.git Middle/Signal
git clone https://github.com/wireapp/wire-ios.git Middle/wire
cd Middle/wire
./setup.sh
cd ../../

git clone https://github.com/sequelpro/sequelpro.git Middle/sequelpro

#Small
git clone https://github.com/yeswolf/CocoaConferences Small/CocoaConferences
git clone https://github.com/paulrehkugler/xkcd.git Small/xkcd
