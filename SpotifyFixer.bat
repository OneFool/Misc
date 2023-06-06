:: SpotifyFixer by OneFool#7876
:: Use this if your Spotify bugs out and you can't pause/play music etc.
:: This will close out all instances of Spotify which task manager usually doesn't do if Spotify is bugged resulting in;
:: the "Spotify is not responding" message when you try to re-launch it.

:: Kill all instances of Spotify.
taskkill /f /im Spotify.exe /T > nul

:: Re-Launch Spotify, Make sure to replace the example path with your Spotify.exe path.
START C:\Users\OneFool\AppData\Roaming\Spotify\Spotify.exe
