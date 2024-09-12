@echo off
move "C:\HWID Bypass\STEP 4 - Change your Disk Serial NumberID\_\Volumeid.exe" "C:\" >nul
move "C:\HWID Bypass\STEP 4 - Change your Disk Serial NumberID\_\Volumeid64.exe" "C:\" >nul
@echo Volume ID Files were moved to C: drive
@echo off
Setlocal EnableDelayedExpansion

Set _RNDLength=4
Set _Alphanumeric=0123456789ABCDEF

:: Function to generate a random serial number
:generate_serial
Set _Str=%_Alphanumeric%987654321
:_LenLoop
IF NOT "%_Str:~18%"=="" SET _Str=%_Str:~9%& SET /A _Len+=9& GOTO :_LenLoop
SET _tmp=%_Str:~9,1%
SET /A _Len=_Len+_tmp
Set _count=0
SET _RndAlphaNum=
:_loop
Set /a _count+=1
SET _RND=%Random%
Set /A _RND=_RND%%%_Len%
SET _RNDZ=%Random%
Set /A _RNDZ=_RNDZ%%%_Len%
SET _RndAlphaNum=!_RndAlphaNum!!_Alphanumeric:~%_RND%,1!
SET _RndAlphaNumz=!_RndAlphaNumz!!_Alphanumeric:~%_RNDZ%,1!
If !_count! lss %_RNDLength% goto _loop
SET _NewSerial=!_RndAlphaNum!-!_RndAlphaNumz!
goto :eof

:: Get all available drives
@echo ----------------------------------------------------------------------------------------------------------------
@echo Below you can see a full list with all your drives: 
fsutil fsinfo drives
@echo ----------------------------------------------------------------------------------------------------------------

:: Loop through all drives and change their serial numbers
for %%D in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    vol %%D: >nul 2>&1
    if not errorlevel 1 (
        call :generate_serial
        @echo Changing serial number of drive %%D: to !_NewSerial!
        volumeid.exe %%D: !_NewSerial!
        @echo Drive %%D: serial number successfully changed to !_NewSerial!
        @echo ----------------------------------------------------------------------------------------------------------------
    )
)

pause
