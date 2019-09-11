http://qubodup.itch.io/startgamedev
Start Gamedev is a collection of tools to make it easy to start game development and port your LÖVE game to Android.

Android steps:
1. Create zip with your game, rename to "game.love" in this folder
2. Start the make-apk script - this will create "game.apk"
3. Copy "game.apk" to your Android device and open it in the file browser to install

Linux users will need to install jdk, ant and android-sdk with platform tools and build tools v19

That is it.

OPTIONAL Steps:
4. Replace icon.png (144x144px png) and run the make-apk script again.
5. Edit the make-apk script to change the app id and name.

For more, for now, check love-android-sdl2 wiki for more info.

Background info:
tools\ant is from https://ant.apache.org/bindownload.cgi ; removed documentation, maybe more
tools\jdk is from http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html JDK, NOT JRE, NOT JAVA PLATFORM , openjdk didn't work; removed as much as I could without breaking ant debug
tools\android is downloaded with Android SDK Manager https://developer.android.com/sdk/index.html SDK TOOLS ONLY, NOT ANDROID STUDIO; removed as much as possible without breaking ant debug
tools\love-android-sdl2 from https://bitbucket.org/MartinFelis/love-android-sdl2 , self-compiled early 2015

CREDITS
Collected by Iwan Gabovitch http://qubodup.net
Check subdirectories for licenses and credits
StartGamedev-170112
