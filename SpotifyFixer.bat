:: SpotifyFixer by OneFool#7876
:: Use this if your spotify bugs out and you can't pause/play music etc.
taskkill /f /im Spotify.exe /T > nul
timeout /t 1 /nobreak
:: Replace the example Spotify.exe path below with your path.
START C:\Users\OneFool\AppData\Roaming\Spotify\Spotify.exe
