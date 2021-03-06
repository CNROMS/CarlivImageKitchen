::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::                                                    :::
:::          Carliv Image Kitchen for Android          :::
:::   boot+recovery images copyright-2015 carliv@xda   :::
:::   including support for MTK powered phones images  :::
:::                                                    :::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off
cd "%~dp0"
IF EXIST "%~dp0\bin" SET PATH=%PATH%;"%~dp0\bin"
chmod -R 755 bin
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
Setlocal EnableDelayedExpansion
set "red=\033[31m"
set "cyan=\033[96m"
set "yellow=\033[43m"
set "deft=\033[0m"
echo(    
echo **********************************************************
echo *                                                        *
echo *         %cyan%Carliv Image Kitchen for Android %deft%v0.3          * | klr
echo *     boot+recovery images copyright-2015 %cyan%carliv@xda%deft%     * | klr
echo *    including support for MTK powered phones images     *
echo *                     WINDOWS version                    *
echo *               Cleaning the working folder              *
echo *                                                        *
echo **********************************************************
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
for /d %%g in ("%~dp0\*") do if not %%g == bin rd /s /q %%g >nul
if not exist "*.img-infos.txt" goto end
for /f %%a in ("*.img-infos.txt") do del %%a >nul
echo(
echo(
:end
