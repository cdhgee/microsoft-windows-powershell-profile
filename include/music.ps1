Function Move-RippedMusic {

  Get-ChildItem E:\Music\Rips -Filter *.mp3 | Move-Item -Destination "E:\Music\Music Library Incoming"

}
