REM most of the things should be parametrized
REM ZAP daemon skal startes a en anden job
REM call echo "start a daemon zap"
REM call java -jar %ZAPPROXY_HOME%\zap-2.9.0.jar -daemon -port 8090 -config api.disablekey=true
REM do spider scan
call echo "spider scan"
call curl "http://localhost:8090/JSON/spider/action/scan/?zapapiformat=JSON&formMethod=GET&url=http://localhost:8080/WebGoat"

call echo "aktive scan"
call curl "http://localhost:8090/JSON/ascan/action/scan/?zapapiformat=JSON&formMethod=GET&url=http://localhost:8080/WebGoat&recurse=&inScopeOnly=&scanPolicyName=&method=&postData=&contextId="
call echo "Vent 20 sekunder"
call timeout 20
REM gem report et bestemt sted
call curl "http://127.0.0.1:8090/OTHER/core/other/jsonreport/?formMethod=GET" > ZAP_Report.json
call curl "http://127.0.0.1:8090/JSON/alert/view/alertsSummary/"
call curl "http://127.0.0.1:8090/JSON/alert/view/alertsSummary/" | findstr "\"High\":0"
echo %ERRORLEVEL%
REM ERRORLEVEL 0 = fund, 1= not found

IF NOT ERRORLEVEL 1 (echo "No risk") else ( exit /b %ERRORLEVEL%)
