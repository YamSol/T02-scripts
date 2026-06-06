@echo off
title Keep Awake
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Add-Type -AssemblyName System.Windows.Forms; ^
   $sig = '[DllImport(\"user32.dll\")] public static extern void mouse_event(int f, int x, int y, int d, int e);'; ^
   $m = Add-Type -MemberDefinition $sig -Name Mouse -Namespace W -PassThru; ^
   while ($true) { ^
     $pos = [System.Windows.Forms.Cursor]::Position; ^
     $m::mouse_event(1, 1, 0, 0, 0); ^
     $m::mouse_event(1, -1, 0, 0, 0); ^
     [System.Windows.Forms.Cursor]::Position = $pos; ^
     Start-Sleep -Seconds 60 ^
   }"
