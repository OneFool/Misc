:: SpotifyFixer by OneFool#7876
taskkill /f /im Spotify.exe /T > nul
timeout /t 1 /nobreak
:: Replace the example Spotify.exe path below with your path.
START C:\Users\OneFool\AppData\Roaming\Spotify\Spotify.exe
