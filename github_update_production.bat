@echo off
setlocal
title GitHub Update - PRODUCTION
cd /d "%~dp0"
cls

echo.
echo  ############################################
echo  #      🚀 GITHUB PIPELINE: PRODUCTION      #
echo  ############################################
echo.

:: Tenta mudar para a branch main (Producao). Se nao existir, ele cria.
git checkout main 2>nul || git checkout -b main

:: Adiciona todos os arquivos alterados
git add .

:: Pede a mensagem do commit
set /p msg="▶ Digite a mensagem do commit (ou de Enter para padrao): "
if "%msg%"=="" set msg="chore: auto-update production"

:: Salva e envia para o GitHub
git commit -m "%msg%"
git push -u origin main

echo.
echo ✅ Feito! Codigo atualizado e salvo na branch PRODUCTION (main).
pause
endlocal