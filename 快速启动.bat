@echo off
chcp 65001 >nul
title 云南古建筑数字馆 - 快速启动

echo.
echo ╔══════════════════════════════════════════════════════════╗
echo ║          云南古建筑数字馆 - 快速启动                      ║
echo ╠══════════════════════════════════════════════════════════╣
echo ║  请选择启动方式:                                        ║
echo ║                                                          ║
echo ║  [1] 本地服务器启动 (推荐，功能完整)                    ║
echo ║  [2] 直接打开文件 (最快，部分功能可能受限)              ║
echo ║  [3] 使用Node.js启动 (需要安装Node.js)                  ║
echo ╚══════════════════════════════════════════════════════════╝
echo.

set /p choice="请输入选择 [1/2/3]: "

if "%choice%"=="1" goto server
if "%choice%"=="2" goto direct
if "%choice%"=="3" goto node
goto end

:server
echo.
echo [信息] 正在启动Python HTTP服务器...
cd /d "%~dp0"

:: 检查Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到Python，请选择其他启动方式
    pause
    exit /b 1
)

set PORT=8080
start "" cmd /c "timeout /t 1 /nobreak >nul && start http://localhost:%PORT%"
echo [信息] 服务器已启动: http://localhost:%PORT%
python -m http.server %PORT%
goto end

:direct
echo.
echo [信息] 正在直接打开网页...
cd /d "%~dp0"
start "" "index.html"
echo [提示] 已在浏览器中打开，如遇问题请使用服务器模式
goto end

:node
echo.
echo [信息] 正在使用Node.js启动...
cd /d "%~dp0"

:: 检查Node.js
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到Node.js，请选择其他启动方式
    echo [提示] 可从 https://nodejs.org 下载安装
    pause
    exit /b 1
)

:: 检查是否安装了http-server
npx http-server --version >nul 2>&1
echo [信息] 正在启动Node.js HTTP服务器...
set PORT=8080
start "" cmd /c "timeout /t 1 /nobreak >nul && start http://localhost:%PORT%"
npx -y http-server -p %PORT% -c-1
goto end

:end
pause