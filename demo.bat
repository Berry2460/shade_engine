echo off
cls
setlocal enabledelayedexpansion
title Shade_Engine Demo
color 07
mode 40,20
goto setup
:setup
set model=demo_model
set cx=7
set cy=7
set turn=1
set render=6
set floor=--
set sky=..
set wmax=1
set w1f=##
set w1s=@@
set x=0
set y=1
:fill
set /a x+=1
set m%x%m%y%=n
if %x% == 1 set m%x%m%y%=1
if %x% == 15 set m%x%m%y%=1&set /a y+=1&set x=0
if %y% == 1 set m%x%m%y%=1
if %y% == 15 set m%x%m%y%=1
if %y% == 16 goto main
goto fill
:main
call "Shade_Engine.bat"
echo W, S to move. A, D to turn.
choice /c:wsad /n /m ""
set x=%cx%
set y=%cy%
if "%errorlevel%"=="1" (
if "%turn%"=="1" set /a y=%cy%-1
if "%turn%"=="2" set /a x=%cx%+1
if "%turn%"=="3" set /a y=%cy%+1
if "%turn%"=="4" set /a x=%cx%-1
)
if "%errorlevel%"=="2" (
if "%turn%"=="1" set /a y=%cy%+1
if "%turn%"=="2" set /a x=%cx%-1
if "%turn%"=="3" set /a y=%cy%-1
if "%turn%"=="4" set /a x=%cx%+1
)
if "!m%x%m%y%!"=="n" (
set cx=%x%
set cy=%y%
)
if "%errorlevel%"=="3" set /a turn-=1
if "%errorlevel%"=="4" set /a turn+=1
goto main
