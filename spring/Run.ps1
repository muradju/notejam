$image = "nordcloud/notejam-spring"
$httpPort=8080

docker run -p "$($httpPort):8080" -it --rm  "$($image):latest"
