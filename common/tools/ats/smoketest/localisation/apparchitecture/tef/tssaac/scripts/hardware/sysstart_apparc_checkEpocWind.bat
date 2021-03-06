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

set TEST_CASE=%1
set EPOCWIND=\epoc32\data\z\apparctest\logs\%TEST_CASE%.log

set DABS_FLAG=%2

set HARDWARE_REFERENCE_PLATFORM=%3

goto :skipFunctions

:checkLog
	:: checkLog SEARCH_STRING EXPECTED_NUMBER_OF_OCCURENCES
	set SEARCH_STRING=%1
	set TEMP_FILE=sysstart_temp.txt
	set EXPECTED_COUNT=%2
	set LOG_COUNT=0
	type %EPOCWIND% | find /c %SEARCH_STRING%>%TEMP_FILE%
	for /f "delims=\" %%i in ('type %TEMP_FILE%') do set LOG_COUNT=%%i
	del %TEMP_FILE%
	if "%EXPECTED_COUNT%" ==  "%LOG_COUNT%" goto :EOF
	if "%EXPECTED_COUNT%" NEQ "%LOG_COUNT%" set TEST_RESULT_FLAG=false
goto :EOF

:initialise
	set SSAAC_RESULT_FILE=\epoc32\data\z\apparctest\T_SSAAC_PanicResultFile.txt
	if exist %SSAAC_RESULT_FILE% del %SSAAC_RESULT_FILE% >NUL
	set TEST_RESULT_FLAG=true
goto :EOF

:T_TestStartApp2L       
:T_TestStartApp3L       
:T_TestStartApp4L	  
:T_TestStartApp5L       
:T_TestStartApp6L            
:T_TestInsertDataTypeL  
:T_TestAppForDataTypeL  
:T_TestDeleteDataTypeL  
:T_TestServiceDiscovery 
:T_TestGetAppInfo       
:T_TestGetAllApps       
:T_TestCreateDoc 
:T_TestAppCount
	call :initialise
	call :checkLog "CSysStartApparcTestCase: Error connecting to RApaLsSession (err=-1)" 1
	call :checkLog "Thread tssaac.exe::Main Panic KERN-EXEC 0" 1
	echo Test Case=%TEST_CASE% > %SSAAC_RESULT_FILE%	
	if /i "%TEST_RESULT_FLAG%"=="true" echo Result=1 >> %SSAAC_RESULT_FILE%
	if /i "%TEST_RESULT_FLAG%"=="false" echo Result=0 >> %SSAAC_RESULT_FILE%
goto :EOF

:skipFunctions

call :%TEST_CASE%
call \epoc32\data\z\apparctest\sysstart_apparc_buildrom.bat %TEST_CASE% 00 TEST_ROM_ONLY %DABS_FLAG% %HARDWARE_REFERENCE_PLATFORM%

endlocal
