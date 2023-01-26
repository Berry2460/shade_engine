if "%cx%"=="" set cx=1
if "%cy%"=="" set cy=1
if "%render%"=="" set render=5
if %render% lss 2 set render=2
if %render% gtr 7 set render=7
if "%turn%"=="" set turn=1
if %turn% gtr 4 set turn=1
if %turn% lss 1 set turn=4
if "%floor%"=="" set floor=--
if "%sky%"=="" set sky=..
if "%wmax%"=="" set wmax=0
if "%model%"=="" set model=n
goto rayset
:rayset
set ray=0
set return=n
set add=-1
goto newray
:newray
if "%return%"=="y" if "%add%"=="0" goto drawset
set rx=%cx%
set ry=%cy%
set /a ray+=1
if "%return%"=="n" set /a add+=1
if "%return%"=="y" set /a add-=1
if "%turn%"=="1" set /a ry=%cy%-%add%
if "%turn%"=="2" set /a rx=%cx%+%add%
if "%turn%"=="3" set /a ry=%cy%+%add%
if "%turn%"=="4" set /a rx=%cx%-%add%
set rayadd=%add%
if "%turn%"=="1" set hit=f
if "%turn%"=="2" set hit=s
if "%turn%"=="3" set hit=f
if "%turn%"=="4" set hit=s
set rayh=f
set maincast=y
if "%rayadd%"=="%render%" set return=y
goto raycast%rayh%
:hitcheck
set findw=!m%rx%m%ry%!
if %rayadd% gtr %render% (
set r%ray%block=%floor%
set r%ray%add=14
set maincast=n
goto newray
)
if "%findw%"=="n" set maincast=n&goto raycast%rayh%
if "%findw%"=="%wmax%" (
set r%ray%block=!w%findw%%hit%!
set r%ray%add=%rayadd%
if "%maincast%"=="y" set return=y
goto newray
)
if %findw% lss %wmax% (
set r%ray%block=!w%findw%%hit%!
set r%ray%add=%rayadd%
if "%maincast%"=="y" set return=y
goto newray
)
set maincast=n
goto raycast%rayh%
:raycasts
set rayh=f
if "%turn%"=="1" set hit=s
if "%turn%"=="2" set hit=f
if "%turn%"=="3" set hit=s
if "%turn%"=="4" set hit=f
if "%return%"=="n" (
if "%turn%"=="1" set /a rx-=1
if "%turn%"=="2" set /a ry-=1
if "%turn%"=="3" set /a rx+=1
if "%turn%"=="4" set /a ry+=1
)
if "%return%"=="y" (
if "%turn%"=="1" set /a rx+=1
if "%turn%"=="2" set /a ry+=1
if "%turn%"=="3" set /a rx-=1
if "%turn%"=="4" set /a ry-=1
)
goto hitcheck
:raycastf
set /a rayadd+=1
set rayh=s
if "%turn%"=="1" set hit=f
if "%turn%"=="2" set hit=s
if "%turn%"=="3" set hit=f
if "%turn%"=="4" set hit=s
if "%turn%"=="1" set /a ry-=1
if "%turn%"=="2" set /a rx+=1
if "%turn%"=="3" set /a ry+=1
if "%turn%"=="4" set /a rx-=1
goto hitcheck
:drawset
set dray=0
set screenx=0
set screeny=9
set /a remain=16%%ray%
goto newdraw
:newdraw
set /a xspace=16/%ray%
if %remain% gtr 1 set /a xspace=%xspace%+1
set /a remain-=1
if "%dray%"=="%ray%" goto displayset
set /a dray+=1
set /a screenxmax=%screenx%+1
if %dray% lss %ray% set /a screenx+=%xspace%
if "%dray%"=="%ray%" set screenx=16
set screeny=9
set /a yspace=16-2*!r%dray%add!
set flipup=0
set screenadd=1
set tex=!r%dray%block!
set /a yfind=%yspace%+1
goto draw
:draw
if %screenadd% gtr %yspace% if "%ddonecount%"=="%xspace%" set drawdone=y
if %screenadd% lss %yfind% set tblock=%tex%
if %screenadd% gtr %yspace% if %screeny% gtr 9 set tblock=%floor%
if %screenadd% gtr %yspace% if %screeny% lss 9 set tblock=%sky%
set x%screenx%x%screeny%=%tblock%
if "%screenx%"=="%screenxmax%" goto flip
set /a screenx-=1
goto draw
:flip
set ddonecount=0
if "%flipup%"=="0" set /a screeny-=%screenadd%
if "%flipup%"=="1" set /a screeny+=%screenadd%
set /a screenadd+=1
if %dray% lss %ray% set /a screenx+=(%xspace%-1)
if "%dray%"=="%ray%" set screenx=16
if %screenadd% gtr %yspace% (
if "!x%screenx%x%screeny%!"=="%sky%" if "!x%screenxmax%x%screeny%!"=="%sky%" goto newdraw
if "!x%screenx%x%screeny%!"=="%sky%" if "!x%screenxmax%x%screeny%!"=="%floor%" goto newdraw
)
if %screenadd% gtr 16 goto newdraw
set /a flipup+=1
if %flipup% gtr 1 set flipup=0
goto draw
:displayset
cls
if exist "%model%.bat" call "%model%.bat"
set y=0
goto display
:display
set /a y+=1
echo !x1x%y%!!x2x%y%!!x3x%y%!!x4x%y%!!x5x%y%!!x6x%y%!!x7x%y%!!x8x%y%!!x9x%y%!!x10x%y%!!x11x%y%!!x12x%y%!!x13x%y%!!x14x%y%!!x15x%y%!!x16x%y%!
if "%y%"=="16" goto done
goto display
:done
