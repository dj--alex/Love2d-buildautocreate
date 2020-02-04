Этот проект rgeneratepublic.sh (в папке M2K) нужен чтобы за два щелчка мышью
и две секунды сделать удобоваримую компиляцию проектов Love2D
которая не потребует установки для конечного игрока.
* Планируется добавить при первой возможности поддержку APK для андроид с помощью Startdev

Т.е. вы кидаете game.love
А получаете 2-3 архива которые гарантированно пойдут на Linux 64bit, Windows 64bit *i Android.
============

1.В папку M2K ложите вашу игру
Если уже готовый .love файл - называете его m2ktest.lib 
Это требуется для скриптов - пользователь этих всех названий не увидит
конечные вы укажете в другом файле.

в build.ini счётчик билдов.
Если вы как и я делаете .love файл командой sh rebuild.sh
то она автоматически увеличивает счётчик билдов
и добавляет все необходимые папки и main.lua и всё что найдет в папке M2K в .love файл
Папки не добавляются автоматически - добавляются только указанные вами в rebuild папки.
и назовёт его m2ktest.lib

2. В папке M2K-Linux 
Love2d-buildautocreate/m2k-Linux (Именно эту папку увидит пользователь.)
Всё заготавливается 1 раз
create-desktop - файл создание ярлыка на приложение
с вашей иконкой и вашим названием. исправьте как нужно,если надо
ложите заранее в папку руководство и changelog если надо.
start_game - ярлык на запуск
На некоторых ос надо писать ./start_game
m2k-Linux/usr/bin - должна содержать папки которые могут понадобится пользователю
у меня это - Levels, Saves. 
Они должны быть пустые.

3 В папке M2K-Windows
/Love2d-buildautocreate/m2k-Windows/M2k-Win (Именно эту папку увидит пользователь.)
Всё заготавливается 1 раз
ложите заранее в папку руководство и changelog если надо.
Как делать иконку я пока что не знаю.
Папка должна содержать папки которые могут понадобится пользователю
у меня это - Levels, Saves. 
Они должны быть пустые.

4 в папке M2K-Android
должен лежать Startdev для Linux
Если у вас он есть и настроен и работает  ( https://qubodup.itch.io/startgamedev ) 
раскомментруейте в скрипте rgeneratepublic.sh
строки связанные с Android
Будет автоматически генерироватся и андроид версия приложения.
Для настройки для google 64bit apk нужны какие то действия
Возможно лишь создание apk для тестирования пока что.

Для автогенерации подписанных ключем гугл есть решение возможно уже устарело т.к. гугл решил блокировать 64бит приложения
https://love2d.org/forums/viewtopic.php?f=4&t=85554&p=222346#p222346
Если будете почаще оставлять посты с просьбами автор может быть откликнется




==================================================
Generating signed APK for LOVE games under Linux.  * by Шмель Тяжеловес и dj--alex(alxius.r)
==================================================
Based on https://bitbucket.org/MartinFelis/love-android-sdl2/wiki/Building_L%C3%96VE_for_Android_-_Linux

1. git clone https://bitbucket.org/MartinFelis/love-android-sdl2 --recurse-submodules
path=/media/user/D/Programs/Android-compile
--recurse-submodules нужно что-бы кроме обвязки андроида скачались и исходники 

2. Ty muśisz instalować przez synaptic stara wersja Java.
Установить Java 8 ! 11 - слишком новая (внезапно!)  
* default jre 
* openjdk-8-jre

3. У вас могут быть другие пути, подкорректируйте их под свой проект самостоятельно
От неправильно заданного пути может все перестать работать.
/media/user/D/Programs/Android-SDK/tools/bin   (sdkmanager)
paths=/media/user/D/Programs/android-studio  (3.5) 
paths=/media/user/D/Programs/Android-SDK   (19,23 api)

./sdkmanager --licenses
./sdkmanager --update
./sdkmanager ndk-bundle

4.
export ANDROID_HOME=/media/user/D/Programs/Android-SDK/
path= user@PC1:/media/user/D/Programs/Android-compile/love-android-sdl2$
./gradlew
./gradlew assemble
Должно получится: 
BUILD SUCCESSFUL in 8s
1 actionable task: 1 executed

Проверка на вшивость:find . -name "*.apk"

должно быть
user@PC1:/media/user/D/Programs/Android-compile/love-android-sdl2$ find . -name "*.apk"
./app/build/outputs/apk/release/app-release-unsigned.apk
./app/build/outputs/apk/debug/app-debug.apk
user@PC1:/media/user/D/Programs/Android-compile/lov

5. Создать папку и положить в неё свою игру
/home/user/D/Programs/Android-compile/love-android-sdl2/app/src/main/assets
и повторить компиляцию ещё раз.   
Можно и пропустить первую компиляцию  и сразу разместить игру.

скрипт generate_apk.sh должен выглядеть примерно так.:
скрипт прилагается в папке M2K - rgenerate-android.sh

в данный момент он содержит такой код
#!/bin/bash
bver=$(cat build.ini) #&& echo $bver unibuilder v2.1  .  In M2K  build number Тут указываете файл где храните обновляемый номер билда
nazwa=$(cat nazwa.ini) #&& echo $nazwa  In M2K title game  Тут указываете файл где хранится название.
nameandroid="${nazwa}-Android-$bver.apk" #final application love2d lua name
export ANDROID_HOME=/media/user/D/Programs/Android-SDK/  # `ANDROID_NDK_HOME`
SDK="/media/user/D/Programs/Android-SDK/build-tools/28.0.3/" #Your SDK build tools path (Execs)
SDL2="/media/user/D/Programs/Android-compile/love-android-sdl2/" #Love-android-SDL2 path
sed -ie 's/versionName ".*"/versionName "'${bver}'"/' ${SDL2}app/build.gradle
sed -ie 's/applicationId ".*"/applicationId "'${nazwa}'.game"/' ${SDL2}app/build.gradle
sed -ie 's/android:label=".*"/android:label="'${nazwa}'"/' ${SDL2}app/src/main/AndroidManifest.xml
#git clone https://bitbucket.org/MartinFelis/love-android-sdl2 --recurse-submodules  export PATH=${SDK}
cd ..
mkdir ${SDL2}app/src/main/assets # Assets of SDL2
rm ${SDL2}app/src/main/assets/game.love 
rm ${SDL2}love_icon_512x512.png
cp ${nazwa}/m2ktest.lib ${SDL2}app/src/main/assets/game.love
cp ${nazwa}/icon.png ${SDL2}love_icon_512x512.png
cp ${nazwa}/icon.png ${SDL2}app/src/main/res/drawable-xhdpi/love.png  #96x96 only
#cp ${nazwa}/icon.png ${SDL2}app/src/main/res/drawable-hdpi/love.png  #72x72 only
#cp ${nazwa}/icon.png ${SDL2}app/src/main/res/drawable-xxhdpi/love.png  #144x144 only
#cp ${nazwa}/icon.png ${SDL2}app/src/main/res/drawable-xxxhdpi/love.png  #192x192 only
${SDL2}./gradlew  assemble -p ${SDL2} # *** 
zipalign -v -p 4 ${SDL2}app/build/outputs/apk/release/app-release-unsigned.apk ${SDL2}app/build/outputs/apk/release/aligned-"${nameandroid}"
#keytool -genkey -v -keystore my-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias my-alias #--делается 1 раз! 
${SDK}./apksigner sign --ks ${SDL2}my-release-key.jks --out ${SDL2}app/build/outputs/apk/release/"${nameandroid}" ${SDL2}app/build/outputs/apk/release/aligned-"${nameandroid}"

cp ${SDL2}app/build/outputs/apk/release/${nameandroid} NEW/${nameandroid}




