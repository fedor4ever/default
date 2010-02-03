@rem
@rem Copyright (c) 2009 Nokia Corporation and/or its subsidiary(-ies).
@rem All rights reserved.
@rem This component and the accompanying materials are made available
@rem under the terms of the License "Eclipse Public License v1.0"
@rem which accompanies this distribution, and is available
@rem at the URL "http://www.eclipse.org/legal/epl-v10.html".
@rem
@rem Initial Contributors:
@rem Nokia Corporation - initial contribution.
@rem
@rem Contributors:
@rem
@rem Description:
@rem
@echo off
setlocal

call :initialise %1 %2
if /i "%INPUT_ERROR%"=="true" goto :EOF

call :test T_TestStartApp1L		01  

:: if automation is not supported, then don't bother attempting to run
:: the remaining test cases.
if /i "%TEST_MANUAL_FLAG%"=="false" (if /i "%AUTOMATED_FLAG%"=="false" goto :EOF) 
      
call :test T_TestStartApp2L		02        
call :test T_TestStartApp3L		03     
call :test T_TestStartApp4L		04	   
call :test T_TestStartApp5L		05     
call :test T_TestStartApp6L		06     
call :test T_TestGetAllApps		07     
call :test T_TestInsertDataTypeL	08
call :test T_TestAppForDataTypeL	09 
call :test T_TestDeleteDataTypeL	10 
call :test T_TestServiceDiscovery	11  
call :test T_TestGetAppInfo     	12
call :test T_TestAppCount	    	13
call :test T_TestCreateDoc      	14
call :test T_TestLocalisedCaptionL	29

goto :skipFunctions

:help
	echo.
	echo Description:
	echo This script runs the apparc startup test suite on the hardware
	echo reference platform. 
	echo.
	echo Syntax:
	echo %RUN_COMMAND% [choice] [hrp]
	echo where the argument [choice] can be one of:
	echo   "-h" or "help" - this help screen
	echo   "manual"       - run scripts manually i.e. build auto 
	echo                    start ROMs for each test case, but do  
	echo                    not attempt to upload ROM
	echo   "auto"         - run scripts in automated mode, i.e.
	echo			requires USB download to HRP
	echo and argument [hrp] is the hardware reference platform, e.g.
	echo   "h2" or "h4hrp"
	echo.
	echo e.g.
	echo %RUN_COMMAND% auto h4hrp
	echo.
goto :EOF

:initialise
	set APPFWK_COMPONENT=apparctest
	set EPOC_Z=\epoc32\data\z

	set BUILDROM_COMMAND=%EPOC_Z%\%APPFWK_COMPONENT%\sysstart_apparc_buildrom.bat
	set CHECKEPOC_COMMAND=%EPOC_Z%\%APPFWK_COMPONENT%\sysstart_apparc_checkepocwind.bat
	set INSERT_COMMAND=%EPOC_Z%\%APPFWK_COMPONENT%\sysstart_apparc_insertlog.pl
	set RUN_COMMAND=%EPOC_Z%\%APPFWK_COMPONENT%\sysstart_apparc_run.bat

	:: check input values
	set INPUT_ERROR=false
	set TEST_CHOICE=%1
	if /i "%TEST_CHOICE%"=="-h" set INPUT_ERROR=true
	if /i "%TEST_CHOICE%"=="help" set INPUT_ERROR=true
	set TEST_MANUAL_FLAG=false
	if /i "%TEST_CHOICE%"=="manual" set TEST_MANUAL_FLAG=true
	set HARDWARE_REFERENCE_PLATFORM=%2
	if /i "%HARDWARE_REFERENCE_PLATFORM%"=="" set INPUT_ERROR=true
	if /i "%INPUT_ERROR%"=="true" call :help & goto :EOF
	
	set TEST_CASE=INIT_VALUE
	set TEST_RSC=INIT_VALUE
	set TEST_ROM_PORT=1
	set TEST_CASE_TIMEOUT=60

	set TEST_LOG_LOCATION=%EPOC_Z%\%APPFWK_COMPONENT%\logs
	if not exist %TEST_LOG_LOCATION% md %TEST_LOG_LOCATION% 

	set DABS_TEST_LOG_LOCATION=\logs\armv5

	set TEST_LOG=%DABS_TEST_LOG_LOCATION%\%APPFWK_COMPONENT%.log
	if exist %TEST_LOG% del %TEST_LOG%

	set SUMMARY_LOG=%DABS_TEST_LOG_LOCATION%\%APPFWK_COMPONENT%_summary.txt
	if exist %SUMMARY_LOG% del %SUMMARY_LOG% >NUL
goto :EOF

:checkForUsbDrive
	dir %1:\ 2>&1 | find "%1:" >NUL 2>&1
	if ERRORLEVEL 1 goto :EOF
	if not exist %1:\usbload.zip goto :EOF
	echo INFO: %1:\usbload.zip found!
	set HARDWARE_USB=true
	set HARDWARE_USB_DRIVE=%1
goto :EOF

:wait
	echo INFO: Waiting %1 seconds
	ping 1.1.1.1 -w 1000 -n %1 >NUL
goto :EOF

:searchForUSB
	for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do call :checkForUsbDrive %%i
goto :EOF

:checkAutomation
	set AUTOMATED_FLAG=false
	set HARDWARE_USB=false
	if not exist "\trgtest.exe"                          echo INFO: \trgtest.exe not found & goto :EOF
	if not exist "\empty_image_file"                     echo INFO: \empty_image_file not found & goto :EOF
	if not exist "\sync.exe"                             echo INFO: \sync.exe not found & goto :EOF
	if not exist "\hardwareswitch.exe"                   echo INFO: \hardwareswitch.exe not found & goto :EOF
	if not exist "\devcon.exe"                           echo INFO: \devcon.exe not found & goto :EOF
	if not exist "\EJECTDELAY.15"                        echo INFO: \EJECTDELAY.15 not found & goto :EOF
	if not exist "\empty_image_file"                     echo INFO: \empty_image_file not found & goto :EOF
	if not exist "\logs\autorom\dummytest.txt"           echo INFO: \logs\autorom\dummytest.txt not found & goto :EOF
	
	call \devcon.exe remove "USB\Vid_0e22&Pid_1112&Rev_0305" > NUL

	echo INFO: Hardware OFF
	call \hardwareswitch.exe off > NUL
	
	call :wait 2

	echo INFO: Hardware ON
	call \hardwareswitch.exe on > NUL

	call :wait 15
	call :searchForUSB

	if /i "%HARDWARE_USB%"=="true" goto :skipUsbSearch
	call :wait 10 
	call :searchForUSB

	if /i "%HARDWARE_USB%"=="true" goto :skipUsbSearch
	call :usbNotFound 
	goto :EOF

	:skipUsbSearch
	if not exist \logs\armv5 md \logs\armv5 
	set AUTOMATED_FLAG=true
goto :EOF

:usbNotFound
	echo INFO: Target USB Drive not found
	call \hardwareswitch.exe off > NUL
goto :EOF

:upLoadROm
	echo INFO: Uploading ROM to %HARDWARE_USB_DRIVE%:
	if exist "%HARDWARE_USB_DRIVE%:\sys$rom.zip" del %HARDWARE_USB_DRIVE%:\sys$rom.zip
	copy %1 %HARDWARE_USB_DRIVE%:\ > NUL

	del %HARDWARE_USB_DRIVE%:\EJECTDELAY.*
	copy \EJECTDELAY.15 %HARDWARE_USB_DRIVE%:\ > NUL

	echo INFO: Checking %HARDWARE_USB_DRIVE%:
	chkdsk %HARDWARE_USB_DRIVE%: > NUL

	echo INFO: Ejecting %HARDWARE_USB_DRIVE%:
	\sync.exe -r -e %HARDWARE_USB_DRIVE%: > NUL
	call \devcon.exe remove "USB\Vid_0e22&Pid_1112&Rev_0305" >NUL

	echo INFO: Listening to COM%TEST_ROM_PORT% for test results (%TEST_CASE_TIMEOUT% seconds)
	\trgtest.exe %TEST_ROM_PORT% \empty_image_file %TEST_CASE_LOG% %TEST_CASE_TIMEOUT%
	echo INFO: test case log - %TEST_CASE_LOG%

	call \devcon.exe remove "USB\Vid_0e22&Pid_1112&Rev_0305" > NUL

	echo INFO: Hardware OFF
	call \hardwareswitch.exe off > NUL
	
	call :wait 2
goto :EOF

:manualBuild
	set AUTOMATED_FLAG=false
	call %BUILDROM_COMMAND% %TEST_CASE% %TEST_CONFIG% ROM %AUTOMATED_FLAG%
goto :EOF

:test
	set TEST_CASE=%1
	set TEST_CONFIG=%2

	if /i "%TEST_MANUAL_FLAG%"=="true" call :manualBuild & goto :EOF

	set TEST_CASE_LOG=%TEST_LOG_LOCATION%\%TEST_CASE%.log
	set DABS_TEST_CASE_LOG=%DABS_TEST_LOG_LOCATION%\%TEST_CASE%.log

	if exist %TEST_CASE_LOG% del %TEST_CASE_LOG%
	if exist %TEST_CASE_LOG%.original del %TEST_CASE_LOG%.original
	if exist %DABS_TEST_CASE_LOG% del %DABS_TEST_CASE_LOG%
	if exist %DABS_TEST_CASE_LOG%.original del %DABS_TEST_CASE_LOG%.original

	call :checkAutomation

	if /i "%AUTOMATED_FLAG%"=="false" echo ERROR: Automation check failed for rom >> %TEST_CASE_LOG% & goto :EOF

	call %BUILDROM_COMMAND% %TEST_CASE% %TEST_CONFIG% ROM %AUTOMATED_FLAG% %HARDWARE_REFERENCE_PLATFORM%

	if not exist \rom\%TEST_CASE%\sys$rom.zip echo ERROR: \rom\%TEST_CASE%\sys$rom.zip does not exist >> %TEST_CASE_LOG% & goto :logResult

	call :upLoadROm \rom\%TEST_CASE%\sys$rom.zip

	if not exist "\rom\%TEST_CASE%\TEST_ROM_REQUIRED" goto :logResult

	call %CHECKEPOC_COMMAND% %TEST_CASE% %AUTOMATED_FLAG% %HARDWARE_REFERENCE_PLATFORM%

	if not exist \rom\%TEST_CASE%\testrom\sys$rom.zip echo ERROR: \rom\%TEST_CASE%\testrom\sys$rom.zip does not exist >> %TEST_CASE_LOG% & goto :logResult

	call :checkAutomation

	if /i "%AUTOMATED_FLAG%"=="false" echo ERROR: Automation check failed for testrom >> %TEST_CASE_LOG% & goto :logResult

	if exist %TEST_CASE_LOG% copy %TEST_CASE_LOG% %TEST_CASE_LOG%.original >NUL
	if exist %TEST_CASE_LOG% del %TEST_CASE_LOG%

	call :upLoadROm \rom\%TEST_CASE%\testrom\sys$rom.zip

	:logResult
	if not exist %TEST_CASE_LOG% echo ERROR in test execution > %TEST_CASE_LOG% 

	:: add the test case log to the overall test log, which will then be split by the DABS scripts.
	type %TEST_CASE_LOG% >> %TEST_LOG%

	:: copy the test log files across for debugging test runs
	:: NOTE: these won't be reported on the DABS html pages, but can be checked if further info is required
	:: after a failed test case
	copy %TEST_CASE_LOG% %DABS_TEST_CASE_LOG% > NUL
	if exist %TEST_CASE_LOG%.original copy %TEST_CASE_LOG%.original %DABS_TEST_CASE_LOG%.original > NUL

	:: DABS looks for '_epocwind.txt' extension to then include these logs as epocwind
	:: logs, which is useful for debugging what went wrong in case of failure
	copy %TEST_CASE_LOG% %DABS_TEST_LOG_LOCATION%\TESTEXECUTE%APPFWK_COMPONENT%_%TEST_CASE%_epocwind.txt >NUL
	if exist %TEST_CASE_LOG%.original copy %TEST_CASE_LOG%.original %DABS_TEST_LOG_LOCATION%\TESTEXECUTE%APPFWK_COMPONENT%_%TEST_CASE%_epocwind.txt >NUL

	:: insert result into DABS testlog
	call :insertResult

	call :updateTestSummary
goto :EOF

:insertResult
	:: DABS uses this format in the testlog when building the result summary html page
	set RUNNING_TEXT="9999-99-99=99:99:99 Running <TESTEXECUTE%APPFWK_COMPONENT%_%TEST_CASE%.script.htm> for udeb"
	set LOCATION_TEXT="9999-99-99=99:99:99   Log location: <\logs\armv5\TESTEXECUTE%APPFWK_COMPONENT%_%TEST_CASE%.script.htm>"

	set SEARCH_TEXT="Log location: <\\logs\\armv5\\TESTEXECUTEapparctest_t_StartDoc.script.htm>"

	if not exist %DABS_TEST_LOG_LOCATION%\testlog.txt echo ERROR: %DABS_TEST_LOG_LOCATION%\testlog.txt does not exist & goto :EOF
	perl %INSERT_COMMAND% %DABS_TEST_LOG_LOCATION%\testlog.txt %SEARCH_TEXT% %RUNNING_TEXT% %LOCATION_TEXT% 
goto :EOF

:checkLog
	:: checkLog SEARCH_FILE SEARCH_STRING EXPECTED_NUMBER_OF_OCCURENCES
	set SEARCH_FILE=%1
	set SEARCH_STRING=%2
	set TEMP_FILE=sysstart_temp.txt
	set EXPECTED_COUNT=%3
	set LOG_COUNT=0
	type %SEARCH_FILE% | find /c %SEARCH_STRING%>%TEMP_FILE%
	for /f "delims=\" %%i in ('type %TEMP_FILE%') do set LOG_COUNT=%%i
	del %TEMP_FILE%
	if "%EXPECTED_COUNT%" ==  "%LOG_COUNT%" goto :EOF
	if "%EXPECTED_COUNT%" NEQ "%LOG_COUNT%" set TEST_RESULT_FLAG=FAIL
goto :EOF

:updateTestSummary
	set TEST_RESULT_FLAG=PASS
	call :checkLog %DABS_TEST_LOG_LOCATION%\%TEST_CASE%.log "%TEST_CASE% ***Result = PASS" 1
	echo %TEST_CASE% - %TEST_RESULT_FLAG% >> %SUMMARY_LOG%
goto :EOF

:skipFunctions


endlocal