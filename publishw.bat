echo 111
xcopy .\* D:\kirileec.github.io\ /Y /S /E /F /Q
cd ..
rd /s /q public
git add . -A
git commit -m "update"
git push origin
cd D:\kirileec.github.io\
git add . -A
git commit -m "update"
git push origin