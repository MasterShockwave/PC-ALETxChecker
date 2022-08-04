REM Check this for accurate frequencies (07/07/2022)
REM This script has a -3kHz offset from HFLink frequency, to ensure no interference. G90 also seems to tune better above the as-tuned freq anyway.

ECHO off

set COM=COM11

set /a freq=1843000-1000
rigctl -m 370 -r %COM% F %freq%
rem ATU TUNE command
rigctl -m 370 -r %COM% w \0xFE\0xFE\0x88\0xE0\0x1C\0x01\0x02\0xFD
timeout /t 15

set /a freq=3596000-1000
rigctl -m 370 -r %COM% F %freq%
rem ATU TUNE command
rigctl -m 370 -r %COM% w \0xFE\0xFE\0x88\0xE0\0x1C\0x01\0x02\0xFD
timeout /t 15

set /a freq=3600500-1000
rigctl -m 370 -r %COM% F %freq%
rem ATU TUNE command
rigctl -m 370 -r %COM% w \0xFE\0xFE\0x88\0xE0\0x1C\0x01\0x02\0xFD
timeout /t 15

set /a freq=7102000-1000
rigctl -m 370 -r %COM% F %freq%
rem ATU TUNE command
rigctl -m 370 -r %COM% w \0xFE\0xFE\0x88\0xE0\0x1C\0x01\0x02\0xFD
timeout /t 15

set /a freq=7185000-1000
rigctl -m 370 -r %COM% F %freq%
rem ATU TUNE command
rigctl -m 370 -r %COM% w \0xFE\0xFE\0x88\0xE0\0x1C\0x01\0x02\0xFD
timeout /t 15

set /a freq=10131000-1000
rigctl -m 370 -r %COM% F %freq%
rem ATU TUNE command
rigctl -m 370 -r %COM% w \0xFE\0xFE\0x88\0xE0\0x1C\0x01\0x02\0xFD
timeout /t 15

set /a freq=10145500-1000
rigctl -m 370 -r %COM% F %freq%
rem ATU TUNE command
rigctl -m 370 -r %COM% w \0xFE\0xFE\0x88\0xE0\0x1C\0x01\0x02\0xFD
timeout /t 15

set /a freq=14109000-1000
rigctl -m 370 -r %COM% F %freq%
rem ATU TUNE command
rigctl -m 370 -r %COM% w \0xFE\0xFE\0x88\0xE0\0x1C\0x01\0x02\0xFD
timeout /t 15

set /a freq=14346000-1000
rigctl -m 370 -r %COM% F %freq%
rem ATU TUNE command
rigctl -m 370 -r %COM% w \0xFE\0xFE\0x88\0xE0\0x1C\0x01\0x02\0xFD
timeout /t 15

set /a freq=18106000-1000
rigctl -m 370 -r %COM% F %freq%
rem ATU TUNE command
rigctl -m 370 -r %COM% w \0xFE\0xFE\0x88\0xE0\0x1C\0x01\0x02\0xFD
timeout /t 15

set /a freq=18117500-1000
rigctl -m 370 -r %COM% F %freq%
rem ATU TUNE command
rigctl -m 370 -r %COM% w \0xFE\0xFE\0x88\0xE0\0x1C\0x01\0x02\0xFD
timeout /t 15

set /a freq=21096000-1000
rigctl -m 370 -r %COM% F %freq%
rem ATU TUNE command
rigctl -m 370 -r %COM% w \0xFE\0xFE\0x88\0xE0\0x1C\0x01\0x02\0xFD
timeout /t 15

set /a freq=21432500-1000
rigctl -m 370 -r %COM% F %freq%
rem ATU TUNE command
rigctl -m 370 -r %COM% w \0xFE\0xFE\0x88\0xE0\0x1C\0x01\0x02\0xFD
timeout /t 15

set /a freq=24926000-1000
rigctl -m 370 -r %COM% F %freq%
rem ATU TUNE command
rigctl -m 370 -r %COM% w \0xFE\0xFE\0x88\0xE0\0x1C\0x01\0x02\0xFD
timeout /t 15

set /a freq=24932000-1000
rigctl -m 370 -r %COM% F %freq%
rem ATU TUNE command
rigctl -m 370 -r %COM% w \0xFE\0xFE\0x88\0xE0\0x1C\0x01\0x02\0xFD
timeout /t 15

set /a freq=28146000-1000
rigctl -m 370 -r %COM% F %freq%
rem ATU TUNE command
rigctl -m 370 -r %COM% w \0xFE\0xFE\0x88\0xE0\0x1C\0x01\0x02\0xFD
timeout /t 15

set /a freq=28312500-1000
rigctl -m 370 -r %COM% F %freq%
rem ATU TUNE command
rigctl -m 370 -r %COM% w \0xFE\0xFE\0x88\0xE0\0x1C\0x01\0x02\0xFD
timeout /t 15

ECHO All done, happy ALEing!
pause