adb devices
pause 
xcopy /s /y /q assets\* ..\..\..\
ant -file build.xml release
pause
adb install -r bin\cocos2dxandroid-release.apk
pause