@echo off
chcp 65001
cls

:: Renk Ayarı: Yeşil
color 0A

:: Başlık
echo **************************************
echo             WinToolbox           
echo             ULAŞ KÜLEKÇİ              
echo **************************************
pause

:MENU
cls
echo ======================================
echo            WinToolbox       
echo ======================================
echo  1.  Bilgisayar Seri No, Adı, Marka, Model
echo  2.  IP Adresini Görüntüle
echo  3.  Windows Lisans Durumu
echo  4.  Sistem Bilgilerini Görüntüle
echo  5.  Windows Sürüm Bilgisi (winver)
echo  6.  Son Format Tarihini Göster
echo  7.  Disk Durumunu Kontrol Et
echo  8.  Windows Güncelleme Durumu
echo  9.  CPU Bilgilerini Göster
echo 10.  RAM Kullanımını Göster
echo 11.  Grup Politikalarını Güncelle
echo 12.  Kullanıcı Hesaplarını Listele
echo 13.  Depolama Alanı Durumunu Göster
echo 14.  Sabit Diski Tarama (chkdsk)
echo 15.  Güvenlik Duvarını Kapat
echo 16.  Güvenlik Duvarını Aç
echo 17.  Windows Sistem Dosyalarını Onar
echo 18.  Disk Temizliği Başlat
echo 19.  Tüm Programları Güncelle (winget)
echo 20.  Windows Store Uygulamalarını Güncelle
echo 21.  DNS Önbelleğini Temizle
echo 22.  Gereksiz Dosyaları Temizle
echo 23.  RAM Optimizasyonu Yap
echo 24.  Ping Testi Yap
echo 25.  Tracert (Yol İzleme) Yap
echo 26.  Nslookup (DNS Sorgulaması) Yap
echo 27.  Netstat (Bağlantı Durumu) Göster
echo 28.  ARP Tablosunu Göster
echo 29.  Route Tablosunu Göster
echo 30.  Nbtstat (NetBIOS Durumu) Göster
echo 31.  IP Yapılandırmasını Görüntüle
echo 32.  IP Yapılandırmasını Serbest Bırak
echo 33.  IP Yapılandırmasını Yenile
echo 34.  Wi-Fi Şifresini Göster
echo 35.  Çıkış
echo ======================================
set /p choice=Lütfen bir seçenek girin (1-35): 

:: Geçerli seçim kontrolü
if %choice% GEQ 1 if %choice% LEQ 35 (
    call :OPTION_%choice%
) else (
    echo Hata: Geçersiz bir seçenek girdiniz. Lütfen 1-35 arasında bir değer girin!
    pause
)

goto MENU

:: ======================== İŞLEMLER ========================

:OPTION_1
cls
echo Bilgisayarın Seri Numarası:
wmic bios get serialnumber
echo.
echo Bilgisayar Adı:
hostname
echo.
echo Marka ve Model:
wmic computersystem get manufacturer, model
pause
goto MENU

:OPTION_2
cls
echo IP Adresi:
ipconfig | findstr /i "IPv4"
pause
goto MENU

:OPTION_3
cls
echo Windows Lisans Durumu:
slmgr /xpr
echo.
echo Windows Lisans Anahtarı:
wmic path softwarelicensingservice get OA3xOriginalProductKey
pause
goto MENU

:OPTION_4
cls
systeminfo
pause
goto MENU

:OPTION_5
cls
start winver
pause
goto MENU

:OPTION_6
cls
for /f "tokens=2 delims==" %%A in ('wmic os get installdate /value ^| find "="') do set install_date=%%A
echo Son Format Tarihi: %install_date:~0,4%-%install_date:~4,2%-%install_date:~6,2%
pause
goto MENU

:OPTION_7
cls
wmic logicaldisk get caption, freespace, size
pause
goto MENU

:OPTION_8
cls
wmic qfe list brief /format:table
pause
goto MENU

:OPTION_9
cls
wmic cpu get caption, deviceid, name, numberofcores, maxclockspeed
pause
goto MENU

:OPTION_10
cls
wmic memorychip get capacity, speed, manufacturer
pause
goto MENU

:OPTION_11
cls
gpupdate /force
pause
goto MENU

:OPTION_12
cls
net user
pause
goto MENU

:OPTION_13
cls
wmic logicaldisk get caption, description, freespace, size
pause
goto MENU

:OPTION_14
cls
chkdsk C: /f /r /x
pause
goto MENU

:OPTION_15
cls
netsh advfirewall set allprofiles state off
pause
goto MENU

:OPTION_16
cls
netsh advfirewall set allprofiles state on
pause
goto MENU

:OPTION_17
cls
sfc /scannow
pause
goto MENU

:OPTION_18
cls
cleanmgr
pause
goto MENU

:OPTION_19
cls
winget upgrade --all
pause
goto MENU

:OPTION_20
cls
powershell -Command "Get-AppxPackage | Foreach {Add-AppxPackage -Path $_.InstallLocation}"
pause
goto MENU

:OPTION_21
cls
ipconfig /flushdns
pause
goto MENU

:OPTION_22
cls
del /q /f /s %TEMP%\*
pause
goto MENU

:OPTION_23
cls
taskkill /f /im explorer.exe
start explorer.exe
pause
goto MENU

:OPTION_24
cls
set /p ip=Ping yapılacak IP adresini girin: 
ping %ip%
pause
goto MENU

:OPTION_25
cls
set /p ip=Yol izlenecek IP adresini girin: 
tracert %ip%
pause
goto MENU

:OPTION_26
cls
set /p domain=DNS sorgusu yapılacak adresi girin: 
nslookup %domain%
pause
goto MENU

:OPTION_27
cls
netstat -an
pause
goto MENU

:OPTION_28
cls
arp -a
pause
goto MENU

:OPTION_29
cls
route print
pause
goto MENU

:OPTION_30
cls
nbtstat -n
pause
goto MENU

:OPTION_31
cls
ipconfig /all
pause
goto MENU

:OPTION_32
cls
ipconfig /release
pause
goto MENU

:OPTION_33
cls
ipconfig /renew
pause
goto MENU

:OPTION_34
cls
color 0A
echo ===================================
echo         Wi-Fi Şifre Gösterici      
echo ===================================
echo.
echo Sistemde kayıtlı Wi-Fi ağları:
echo -----------------------------------
netsh wlan show profiles | findstr "All User Profile"
echo -----------------------------------
set /p wifi="Şifresini görmek istediğiniz Wi-Fi ağını girin: "
netsh wlan show profile name="%wifi%" key=clear >nul 2>&1
if errorlevel 1 (
    echo Hata: "%wifi%" adında bir Wi-Fi ağı bulunamadı.
    pause
    goto MENU
)
echo ===================================
echo Şifre bilgisi:
netsh wlan show profile name="%wifi%" key=clear | findstr /i "Key Content"
echo ===================================
pause
goto MENU

:OPTION_35
exit
