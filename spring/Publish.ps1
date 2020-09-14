param (
    [Parameter(Mandatory)][string]$Images,
    [Parameter(Mandatory)][string]$Version,
    [Parameter(Mandatory)][string]$DockerRepo,
    [Parameter(Mandatory)][string]$DockerUsername,
    [Parameter(Mandatory)][string]$DockerPassword
)

Write-Host "version : $Version"

docker login -u $DockerUsername -p $DockerPassword $DockerRepo

if ($? -eq $False) {
    Write-Host "Can't login to docker repo"
    Exit 1
}

$imageList = $Images.Split(',')
Foreach ($image in $imageList)
{
    $latestTag = $image + ':latest'

    $versionTag = $image + ':' + $Version
    docker tag $latestTag $versionTag

    $dockerRepoLatestTag = $DockerRepo + '/' + $latestTag
    docker tag $latestTag $dockerRepoLatestTag
    docker push ($dockerRepoLatestTag)

    $dockerRepoVersionTag = $DockerRepo + '/' + $versionTag
    docker tag $latestTag $dockerRepoVersionTag
    docker push ($dockerRepoVersionTag)
}
