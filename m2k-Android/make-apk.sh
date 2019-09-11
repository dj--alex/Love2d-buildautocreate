export PWD=`pwd`
export ARCH=`uname -m`

if [ $ARCH = "i686" ] ; then
  export BIT="32"
elif [ $ARCH = "x86_64" ]; then
  export BIT="64"
else
  echo this tool only supports x86 and x64 architecture
  exit 1
fi

export JAVA_HOME="$PWD/tools/jdk-linux$BIT"
export ANT_HOME="$PWD/tools/ant"
export PATH="$ANT_HOME/bin:$JAVA_HOME:$PATH"
export ANDROID_HOME="$PWD/tools/android-linux"

## make android ID and name unique so we can have multiple installs
# restore original manifest and src subdir
cp tools/love-android-sdl2/original/AndroidManifest.xml tools/love-android-sdl2/
rm tools/love-android-sdl2/src/love -r
cp tools/love-android-sdl2/original/love tools/love-android-sdl2/src/ -r

# get date and hope no participants compile at the same second
datevar=`date +"%m%d%H%M%S"`

# replace id, name and src subdir
sed -i "s/loveToAndroid Game/Game $datevar/g" tools/love-android-sdl2/AndroidManifest.xml
sed -i "s/love.to.android/love\.to\.android$datevar/g" tools/love-android-sdl2/AndroidManifest.xml
sed -i "s/love.to.android/love\.to\.android$datevar/g" tools/love-android-sdl2/src/love/to/android/LtaActivity.java
mv tools/love-android-sdl2/src/love/to/android tools/love-android-sdl2/src/love/to/android$datevar

## make the apk
rm game.apk
cd "tools/love-android-sdl2"
rm -r gen bin

cp ../../game.love assets/
cp ../../icon.png res/drawable-xxhdpi/ic_launcher.png

ant debug

cp bin/love_android_sdl2-debug.apk ../../game.apk
