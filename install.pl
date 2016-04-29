use strict;


system("xcopy /s /y /q assets\\* ..\\..\\..\\");
system("ant -file build.xml release");
system("adb install -r bin\\cocos2dxandroid-release.apk");
<STDIN>;
# ant -file build.xml release
# pause
# adb install -r bin\cocos2dxandroid-release.apk
# pause