@echo off
echo copy to D:\kirileec.github.io\
xcopy .\* D:\kirileec.github.io\ /Y /S /E /F /Q
cd ..
echo remove public dir
rd /s /q public
echo git push source
git add . -A
git commit -m "update"
git push -f origin
echo git push blog
cd D:\kirileec.github.io\
git add . -A
git commit -m "update"
git push -f origin