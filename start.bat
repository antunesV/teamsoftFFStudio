@echo off
setlocal
title TeamSoft FF Studio — CLI Daemon
cls

echo.
echo  ############################################
echo  #                                          #
echo  #      TEAMSOFT FF STUDIO CLI DAEMON       #
echo  #            Architecture V5.2             #
echo  #                                          #
echo  ############################################
echo.

if not exist "backend\node_modules" (
    echo [ERROR] node_modules nao encontrado em \backend.
    echo Executando npm install...
    cd backend && npm install && cd ..
)

echo [INFO] Iniciando o servidor na porta 3000...
cd backend
node index.js

if %ERRORLEVEL% neq 0 (
    echo.
    echo [FATAL] O servidor parou inesperadamente.
    echo Verifique se a porta 3000 esta livre ou se o Node.js esta instalado.
    pause
)
endlocal
