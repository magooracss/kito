; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "ARCON"
#define MyAppVersion "2016.02.01"
#define MyAppPublisher "RACSS Programacion"
#define MyAppURL "http://www.racss.com.ar/alcon"
#define MyAppExeName "arcon.exe"
#define ConfigFile "programa.cfg"
#define bakDir "ar20160201"
#define InstName "arcon-upd01"
#define UpdDB "upddb.exe"


[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{6EDRACSS-CER1-4DA5-A49E-MAGOO89EE342}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName=C:\RACSS\{#MyAppName}
DisableDirPage=yes
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
OutputDir=C:\Dropbox\bak\Trabajo\Trabajo\Windows\kito\inst\salida
OutputBaseFilename={#InstName}
Compression=lzma
SolidCompression=yes

[Languages]
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"

[Files]
; Backup

Source: "{app}\bin\arcon.exe"; DestDir: "{app}\bak\{#bakDir}"; Flags: external skipifsourcedoesntexist
Source: "{app}\db\arcon.fdb"; DestDir: "{app}\bak\{#bakDir}"; Flags:  external skipifsourcedoesntexist
Source: "{app}\bin\programa.cfg"; DestDir: "{app}\bak\{#bakDir}"; Flags: external skipifsourcedoesntexist

; Archivos nuevos
Source: "C:\Dropbox\bak\Trabajo\Trabajo\Windows\kito\inst\entrada\arcon.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "C:\Dropbox\bak\Trabajo\Trabajo\Windows\kito\inst\entrada\upddb.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "C:\Dropbox\bak\Trabajo\Trabajo\Windows\kito\inst\entrada\arcon_20160201.sql"; DestDir: "{app}\db"; Flags: ignoreversion

[Run]
Filename: "{app}\bin\{#Upddb}"; Parameters: "{app}\db\arcon_20160201.sql.sql"; Flags: runmaximized waituntilterminated postinstall; Description: "Actualizar Base de Datos ARCON"
Filename: "{app}\bin\{#MyAppExeName}"; Flags: nowait postinstall skipifsilent; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"