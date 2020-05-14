echo off
cls
setlocal enabledelayedexpansion
title Shade_Engine Demo
color 07
mode 40,20
goto setup
:setup
set model=demo_model
set cx=3
set cy=3
set turn=1
set render=4
set floor=--
set sky=..
set wmax=1
set w1f=##
set w1s=@@
set m1m1=1
set m2m1=1
set m3m1=1
set m4m1=1
set m5m1=1
set m1m2=1
set m2m2=n
set m3m2=n
set m4m2=n
set m5m2=1
set m1m3=1
set m2m3=n
set m3m3=n
set m4m3=n
set m5m3=1
set m1m4=1
set m2m4=n
set m3m4=n
set m4m4=n
set m5m4=1
set m1m5=1
set m2m5=1
set m3m5=1
set m4m5=1
set m5m5=1
goto main
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
