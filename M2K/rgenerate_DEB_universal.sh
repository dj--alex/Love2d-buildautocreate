#!/bin/bash
#Generator DEB for Love.Your app must be in  GAMENAME and near linuxver is GAMENAME-Linux, near GAMENAME-debpack must exist!
bver=$(cat build.ini) #&& echo $bver
nazwa=$(cat nazwa.ini) #&& echo $nazwa
cd ..
mkdir ${nazwa}-debpack/opt
mkdir ${nazwa}-debpack/opt/Games
mkdir ${nazwa}-debpack/opt/Games/${nazwa}-Linux
cp -rf ${nazwa}-Linux ${nazwa}-debpack/opt/Games/
{
echo '[Desktop Entry]'
echo 'Encoding=UTF-8'
echo 'Name='${nazwa}''
echo 'GenericName='${nazwa}''
echo 'Type=Application'
echo 'Categories=Game;'
echo 'Exec="/opt/Games/'${nazwa}'-Linux/start_game"'
echo 'Terminal=false'
echo 'StartupNotify=true'
echo 'Icon=/opt/Games/'${nazwa}'-Linux/icon.png'
echo 'Name[ru]='${nazwa}''
echo 'Comment=Start '${nazwa}''
} > ${nazwa}/${nazwa}.desktop
cp -rf ${nazwa}/${nazwa}.desktop ${nazwa}-Linux/${nazwa}.desktop
cp -rf ${nazwa}-Linux/${nazwa}.desktop ${nazwa}-debpack/opt/Games/${nazwa}-Linux/${nazwa}.desktop
cp -rf ${nazwa}-Linux/${nazwa}.desktop ${nazwa}-debpack/${nazwa}.desktop

cd ${nazwa}-debpack 
#sh create_game_deb_packet.sh
tar czf data.tar.gz opt
echo 2.0 > debian-binary
{
echo 'Package: '${nazwa}'-game'
echo 'Version: '${bver}''
echo 'Architecture: all'
echo 'Maintainer: dj--alex <dj--alex@ya.ru>'
echo 'Original-Maintainer: dj--alex'
echo 'Depends: dialog'
echo 'Description: Recreated simple old 8-bit game. A scientific camp was attacked by tanks. You need to resque the scientists, lead them to an  airgate - the three iron doors (the destination point is marked by the red dots). To win the game you need to save at least 6 scientists. One of 4 game based on M2K self-written engine using power of Lua and Love.'
} > control
{
#!/bin/sh
echo 'cp /opt/Games/'${nazwa}'-Linux/'${nazwa}'.desktop /usr/share/applications/'${nazwa}'.desktop'
} > postinst
tar czf control.tar.gz control postinst
ar -r ${nazwa}-Debian-amd64-b${bver}.deb  debian-binary control.tar.gz data.tar.gz
mv ${nazwa}-debpack/${nazwa}-Debian-amd64-b${bver}.deb NEW


