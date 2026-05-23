@REM ----------------------------------------------------------------------------
@REM Maven Wrapper startup batch script for Windows
@REM ----------------------------------------------------------------------------

@setlocal

set MAVEN_PROJECTBASEDIR=%~dp0
set MAVEN_WRAPPER_JAR="%MAVEN_PROJECTBASEDIR%.mvn\wrapper\maven-wrapper.jar"
set MAVEN_WRAPPER_PROPERTIES="%MAVEN_PROJECTBASEDIR%.mvn\wrapper\maven-wrapper.properties"

@REM Find java.exe
set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto init
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
goto error

:init
set MAVEN_CMD_LINE_ARGS=%*

@REM Download maven-wrapper.jar if not exists
if exist %MAVEN_WRAPPER_JAR% (
    goto execute
) else (
    echo Downloading Maven Wrapper...
    powershell -Command "(New-Object Net.WebClient).DownloadFile('https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.3.2/maven-wrapper-3.3.2.jar', '%MAVEN_PROJECTBASEDIR%.mvn\wrapper\maven-wrapper.jar')"
    if exist %MAVEN_WRAPPER_JAR% goto execute
    echo Failed to download Maven Wrapper jar.
    goto error
)

:execute
"%JAVA_EXE%" ^
  -jar %MAVEN_WRAPPER_JAR% ^
  %MAVEN_CMD_LINE_ARGS%
if ERRORLEVEL 1 goto error
goto end

:error
set ERROR_CODE=1

:end
@endlocal & set ERROR_CODE=%ERROR_CODE%
exit /B %ERROR_CODE%
