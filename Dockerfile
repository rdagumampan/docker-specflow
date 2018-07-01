FROM microsoft/windowsservercore:ltsc2016 as runtime-env

WORKDIR /app

# install .NET 4.7.2
#RUN powershell Invoke-WebRequest -Uri "https://download.microsoft.com/download/5/A/3/5A3607CA-53B1-4717-8845-4389B11931FA/NDP472-KB4054530-x86-x64-AllOS-ENU.exe" -OutFile dotnet-framework-installer.exe & .\dotnet-framework-installer.exe /q & del .\dotnet-framework-installer.exe

# apply latest patch
#RUN powershell -Command $ErrorActionPreference = 'Stop';  $ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -UseBasicParsing -Uri "http://download.windowsupdate.com/d/msdownload/update/software/secu/2018/06/windows10.0-kb4284880-x64_34d88e02608fa8c7db3dda395434d93ba109169c.msu" -OutFile patch.msu; New-Item -Type Directory patch; Start-Process expand -ArgumentList 'patch.msu', 'patch', '-F:*' -NoNewWindow -Wait; Remove-Item -Force patch.msu; Add-WindowsPackage -Online -PackagePath C:\patch\Windows10.0-KB4284880-x64.cab; Remove-Item -Force -Recurse \patch

# ngen .NET Fx
#ENV COMPLUS_NGenProtectedProcess_FeatureEnabled 0
#RUN \Windows\Microsoft.NET\Framework64\v4.0.30319\ngen update & \Windows\Microsoft.NET\Framework\v4.0.30319\ngen update

#install specflow
# deploy binaries
COPY SpecflowTests/bin/Debug .

# deploy xunit consoler runner
COPY packages/xunit.runner.console.2.3.1/tools/net452 ./xunit

# run regression tests on startup
ENTRYPOINT ["c:\\app\\xunit\\xunit.console", "c:\\app\\SpecflowTests.dll", "-html", "c:\\app\\external\\reports\\test-report.html"]