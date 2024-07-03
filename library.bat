rd /s /q c:\garden-affairs\library
xcopy /s /r /k /h /e file:\\xupeng-DT c:\garden-affairs
pause
start "Unity Editor" "C:\Unity 2019.4.40f1\Editor\Unity.exe" -projectPath "C:\garden-affairs"