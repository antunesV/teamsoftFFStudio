@echo off
setlocal
title GitHub Update - DEVELOPMENT
cd /d "%~dp0"
cls

echo.
echo  ############################################
echo  #      🚀 GITHUB PIPELINE: DEVELOPMENT     #
echo  ############################################
echo.

:: Tenta mudar para a branch development. Se ela nao existir, ele cria.
git checkout development 2>nul || git checkout -b development

:: Adiciona todos os arquivos alterados
git add .

:: Pede a mensagem do commit (se voce so der Enter, ele usa uma padrao)
set /p msg="▶ Digite a mensagem do commit (ou de Enter para padrao): "
if "%msg%"=="" set msg="chore: auto-update development"

:: Salva e envia para o GitHub
git commit -m "%msg%"
git push -u origin development

echo.
echo ✅ Feito! Codigo atualizado e salvo na branch DEVELOPMENT.
pause
endlocal