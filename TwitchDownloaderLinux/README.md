# Twitch Downloader für Linux

Eine GTK-3-Desktop-App für TwitchDownloaderCLI. Sie verwendet denselben Download- und Rendering-Code wie das Kommandozeilenprogramm.

## Installation unter Zorin OS, Ubuntu oder Debian (64 Bit, Intel/AMD)

Lade in GitHub Actions unter **Linux Desktop → Artifacts** das Paket `TwitchDownloader-Linux-amd64` herunter und entpacke es. Installiere die enthaltene Datei mit der grafischen Paketverwaltung oder im Terminal mit `sudo apt install ./twitch-downloader_*_amd64.deb`.

Öffne **Twitch Downloader** im Anwendungsmenü. Das Paket enthält die CLI und installiert GTK sowie FFmpeg als Systemabhängigkeiten.

## Start aus dem Quellcode

1. Installiere die Abhängigkeiten mit `sudo apt install python3-gi gir1.2-gtk-3.0 ffmpeg`.
2. Lege die ausführbare Linux-Version von **TwitchDownloaderCLI** neben `twitch-downloader`. Alternativ kannst du sie in der App unter **Optionen und Programme** auswählen oder über `TWITCH_DOWNLOADER_CLI` angeben.
3. Starte `/usr/bin/python3 TwitchDownloaderLinux/twitch-downloader` im Repository.

## Benutzung

- **VOD laden** speichert ein Twitch-Video als MP4 oder den Ton als M4A. Qualität und Zeitbereich lassen sich unter **Optionen und Programme** einstellen.
- **Clip laden** speichert einen Twitch-Clip als MP4.
- **Chat exportieren** speichert den verfügbaren Chat als JSON, HTML oder TXT. Bei JSON kannst du Grafiken für das Offline-Rendering einbetten.
- **Chat rendern** erzeugt aus einem Chat-Export ein MP4. Breite, Höhe und Bildrate sind einstellbar.
- **Stream-Infos** zeigt die von der CLI gelieferten Informationen im Protokoll.

Die App bearbeitet jeweils einen Auftrag und zeigt den CLI-Fortschritt an. Beim Abbruch können angefangene Dateien im Zielordner liegen. Vorhandene Zieldateien werden geschützt.

## Paket bauen

Im Repository mit .NET 10 SDK ausführen:

```sh
dotnet publish TwitchDownloaderCLI -c Release -p:PublishProfile=Linux -o /tmp/twitch-cli
bash TwitchDownloaderLinux/package.sh /tmp/twitch-cli ./dist 1.0.0
```
