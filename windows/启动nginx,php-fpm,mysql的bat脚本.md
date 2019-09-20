@ECHO OFF

::mysql 
pushd C:\WebServer\mariadb\bin
START /b mysqld.exe 
ECHO Starting mysql ......

:: apache2
pushd C:\WebServer\apache\bin
START /b httpd.exe 
ECHO Starting Apache web server ......

::php
pushd C:\WebServer\php7.2
START /b php-cgi.exe -b "127.0.0.1:9000" -c "C:\WebServer\php7.2\php.ini"
ECHO Starting PHP FastCGI ..... 

:: nginx web server
pushd C:\WebServer\nginx
START /b nginx.exe  
ECHO Starting NGINX web server ......

:: messages if you like as a display !
ECHO keep this console open !
