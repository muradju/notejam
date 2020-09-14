$version = Get-Content -Path .\VERSION
Write-Host "version : $version"

# tag it
git add VERSION
git commit -m "version $version"
git tag -a "v$version" -m "version $version"
git push
git push --tags
