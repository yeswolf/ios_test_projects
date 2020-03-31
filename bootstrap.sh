#Hmmm...
if [ ! -d "Hmm/OpenEmu" ]; then
  git clone --recursive https://github.com/OpenEmu/OpenEmu.git Hmm/OpenEmu
fi

#Large
if [ ! -d "Large/eidolon" ]; then
  git clone https://github.com/artsy/eidolon.git Large/eidolon
  cd Large/eidolon
  bundle install
  bundle exec fastlane oss
  cd ../../
fi

if [ ! -d "Large/WWDC" ]; then
  git clone https://github.com/insidegui/WWDC Large/WWDC
  cd Large/WWDC
  ./boostrap.sh
  cd ../../
fi

if [ ! -d "Large/Wordpress" ]; then
  git clone https://github.com/wordpress-mobile/WordPress-iOS.git Large/Wordpress
  cd Large/WordPress
  rake dependencies
  cd ../../
fi
if [ ! -d "Large/focus-ios" ]; then
  git clone https://github.com/mozilla-mobile/focus-ios.git Large/focus-ios
  cd Large/focus-ios
  ./checkout.sh
  cd ../../
fi

if [ ! -d "Large/Telegram" ]; then
  git clone --recursive https://github.com/peter-iakovlev/Telegram-iOS.git Large/Telegram
fi
#Middle

if [ ! -d "Middle/Alamofire" ]; then
  git clone https://github.com/Alamofire/Alamofire.git Middle/Alamofire
fi

if [ ! -d "Middle/OnionBrowser" ]; then
  git clone https://github.com/OnionBrowser/OnionBrowser Middle/OnionBrowser
  cd Middle/OnionBrowser
  rm -rf Carthage/
  brew install automake libtool
  git checkout 2.X
  pod repo update
  pod install
  carthage update --platform iOS
  cd ../../
fi

if [ ! -d "Middle/Riot" ]; then
  git clone https://github.com/vector-im/riot-ios.git Middle/Riot
  cd Middle/Riot
  bundle install
  bundle exec pod install
  cd ../../
fi

if [ ! -d "Middle/Signal" ]; then
  git clone --recursive https://github.com/signalapp/Signal-iOS.git Middle/Signal
  cd Middle/Signal
  gem install cocoapods-binary
  cd ../../
fi

if [ ! -d "Middle/wire" ]; then
  git clone https://github.com/wireapp/wire-ios.git Middle/wire
  cd Middle/wire
  ./setup.sh
  cd ../../
fi

if [ ! -d "Middle/sequelpro" ]; then
  git clone https://github.com/sequelpro/sequelpro.git Middle/sequelpro
fi

#Small
if [ ! -d "Small/CocoaConferences" ]; then
  git clone https://github.com/yeswolf/cocoaconferences-swiftui Small/CocoaConferences
  cd Small/CocoaConferences
  pod install
  cd ../../
fi
if [ ! -d "Small/xkcd" ]; then
  git clone https://github.com/paulrehkugler/xkcd.git Small/xkcd
fi
