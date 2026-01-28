cd ../../../razmanager
flutter build windows
cd ../build/flutter/windows_x64
Compress-Archive -Force -Path ../../../razmanager/build/windows/x64/runner/Release/* -DestinationPath razmanager_windows_x64.zip

pause
