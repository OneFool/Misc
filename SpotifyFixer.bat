:: SpotifyFixer by OneFool#7876
:: Use this if your spotify bugs out and you can't pause/play music etc.
:: This will close out all instances of spotify which task manager usually doesn't do if Spotify is bugged resulting in;
:: the "Spotify is not responding" message when you try to re-launch it.

taskkill /f /im Spotify.exe /T > nul :: Close out Spotify
START C:\Users\OneFool\AppData\Roaming\Spotify\Spotify.exe :: Re-Launch Spotify, make sure to replace the example path with your Spotify.exe path
