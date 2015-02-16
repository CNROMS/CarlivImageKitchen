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
set "red=\033[91m"
set "cyan=\033[96m"
set "yellow=\033[93m"
set "deft=\033[0m"    
echo(    
echo **********************************************************
echo *                                                        *
echo *         %cyan%Carliv Image Kitchen for Android %deft%v0.3          * | klr
echo *     boot+recovery images copyright-2015 %cyan%carliv@xda%deft%     * | klr
echo *    including support for MTK powered phones images     *
echo *                     WINDOWS version                    *
echo *               The unpacking images script              *
echo *                                                        *
echo **********************************************************
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if "%~1" == "" goto noinput
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo Your image:%yellow% %~nx1 %deft% | klr
set "yfile=%~n1"
if "%yfile%"=="%yfile:boot=%" goto recovery
if exist "boot.img" copy "boot.img" "bckp-boot.img" >nul
copy %~nx1  boot.img >nul
set "file=boot.img"
goto unpack
echo(
:recovery
if "%yfile%"=="%yfile:recovery=%" goto error
if exist "recovery.img" copy "recovery.img" "bckp-recovery.img" >nul
copy %~nx1  recovery.img >nul
set "file=recovery.img"
goto unpack
echo(
goto error
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:unpack
echo Create the%yellow% %~n1 %deft%folder. | klr
echo(
set "folder=%~n1"
for /d /r . %%d in (%folder%) do if exist "%%d" rd /s/q "%%d"
md %folder%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo Unpacking the%yellow% %~nx1 %deft%to%yellow% %folder% %deft%folder. | klr
echo(
unpackbootimg -i %file% -o %folder%
if exist %file% del %file% >nul
if exist "bckp-%file%" ren "bckp-%file%" %file% >nul
cd %folder%
for %%a in ("%file%-ramdisk.*") do set ext=%%~xa
echo Compression used:%yellow% %ext:~1% %deft% | klr
type nul > %file%-ramdisk-compress
echo %ext:~1% > "%file%-ramdisk-compress"
echo(
md ramdisk
chmod 755 ramdisk
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo Unpacking the ramdisk....
echo(
goto %ext:~1%
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:gz
cd ramdisk
gzip -dcv "../%file%-ramdisk.gz" | cpio -i
if errorlevel == 1 goto ziperror
cd ..\
del "%file%-ramdisk.gz"
cd ..\
echo(
echo(
echo Done. Your image is unpacked in%yellow% %folder% %deft%folder. | klr
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:lzma
cd ramdisk
xz -dcv "../%file%-ramdisk.lzma" | cpio -i
if errorlevel == 1 goto ziperror
cd ..\
del "%file%-ramdisk.lzma"
cd ..\
echo(
echo(
echo Done. Your image is unpacked in%yellow% %folder% %deft%folder. | klr
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:xz
cd ramdisk
xz -dcv "../%file%-ramdisk.xz" | cpio -i
if errorlevel == 1 goto ziperror
cd ..\
del "%file%-ramdisk.xz"
cd ..\
echo(
echo(
echo Done. Your image is unpacked in%yellow% %folder% %deft%folder. | klr
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:bz2
cd ramdisk
bzip2 -dcv "../%file%-ramdisk.bz2" | cpio -i
if errorlevel == 1 goto ziperror
cd ..\
del "%file%-ramdisk.bz2"
cd ..\
echo(
echo(
echo Done. Your image is unpacked in%yellow% %folder% %deft%folder. | klr
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:error
echo(
echo(
echo %red%Your image name doesn't contain the words%yellow% boot%red% or%yellow% recovery%red%. Don't use this tool for other type of images, or rename your boot and recovery including the type in name. Exit script.%deft% | klr
echo(
echo(
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:ziperror
echo(
echo(
echo %red%Your ramdisk archive is corrupt. Are you trying to unpack a %cyan%MTK%red% image with regular script? If so, please use unpack_MTK_img script. Exit script.%deft% | klr
echo(
echo(
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:noinput
echo(
echo(
echo %red%No image file selected. Exit script.%deft% | klr
echo(
echo(
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:end
echo(
pause