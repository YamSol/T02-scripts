@echo off
setlocal enabledelayedexpansion

:: ============================================================
::  Copia T02-Bloco3 para Documents do usuario atual
:: ============================================================

set "SCRIPT_DIR=%~dp0"
set "ORIGEM=%SCRIPT_DIR%T02-Bloco3"
set "DESTINO=%USERPROFILE%\Documents\T02-Bloco3"

echo ============================================================
echo  Copiando T02-Bloco3 para Documents...
echo ============================================================
echo.

:: --- Verificar se a pasta de origem existe ---
if not exist "%ORIGEM%\" (
    echo [ERRO] Pasta de origem nao encontrada:
    echo        %ORIGEM%
    echo.
    echo Certifique-se de que a pasta "T02-Bloco3" esta no mesmo
    echo diretorio que este script.
    pause
    exit /b 1
)

:: --- Verificar se a pasta de destino ja existe e avisar ---
if exist "%DESTINO%\" (
    echo [AVISO] A pasta de destino ja existe e sera substituida:
    echo         %DESTINO%
    echo.
)

:: --- Executar a copia com robocopy ---
:: /E   = copia subdiretorios (incluindo vazios)
:: /IS  = sobrescreve arquivos identicos
:: /IT  = sobrescreve arquivos com mesmo timestamp
:: /NFL = nao lista arquivos copiados (saida mais limpa)
:: /NDL = nao lista diretorios
echo Copiando arquivos...
robocopy "%ORIGEM%" "%DESTINO%" /E /IS /IT /NFL /NDL

set "RC=%ERRORLEVEL%"

:: Robocopy: codigos 0-7 sao sucesso (8+ indicam erros reais)
if %RC% GEQ 8 (
    echo.
    echo [ERRO] Falha durante a copia. Codigo robocopy: %RC%
    echo Verifique permissoes e espaco em disco.
    pause
    exit /b %RC%
)

echo.
echo [OK] Pasta copiada com sucesso para:
echo      %DESTINO%
echo.

:: --- Abrir no Explorer de forma assincrona e desconecta ---
start "" explorer.exe "%DESTINO%"

echo [OK] Explorer aberto.
echo.
echo Pressione qualquer tecla para fechar...
pause >nul

endlocal
exit /b 0
