@echo off
setlocal
title TeamSoft FF Studio — CLI Daemon

:: 1. Garante que o script rode sempre na pasta dele, mesmo se aberto via atalho
cd /d "%~dp0"
cls

echo.
echo  ############################################
echo  #                                          #
echo  #      TEAMSOFT FF STUDIO CLI DAEMON       #
echo  #            Architecture V5.2             #
echo  #                                          #
echo  ############################################
echo.

:: 2. Verifica se o Node.js esta instalado no Windows
where node >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [FATAL] Node.js nao encontrado no sistema!
    echo Por favor, instale o Node.js antes de continuar.
    pause
    exit /b 1
)

:: 3. Verificacao segura de dependencias
if not exist "backend\node_modules" (
    echo [INFO] Pasta node_modules nao encontrada.
    echo [INFO] Baixando dependencias do servidor...
    cd backend
    :: O comando 'call' impede que o script feche apos o npm terminar!
    call npm install
    if %ERRORLEVEL% neq 0 (
        echo [FATAL] Falha ao instalar dependencias do NPM.
        pause
        exit /b 1
    )
    cd ..
)

echo [INFO] Iniciando o servidor na porta 3000...
cd backend
node index.js

:: 4. Captura de erro elegante
if %ERRORLEVEL% neq 0 (
    echo.
    echo [FATAL] O servidor parou inesperadamente (Codigo de Erro: %ERRORLEVEL%).
    echo Verifique se a porta 3000 esta livre ou se ha erros no codigo.
    pause
)
endlocal