@echo off
title Keep Awake
:loop
powershell -NoProfile -Command "$ws = New-Object -ComObject WScript.Shell; $ws.SendKeys([char]0)"
timeout /t 60 /nobreak >nul
goto loop
