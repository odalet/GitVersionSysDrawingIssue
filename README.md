# GitVersionSysDrawingIssue

Note: this is a repro repository for <https://github.com/GitTools/GitVersion/issues/2576>.

However, <https://github.com/GitTools/GitVersion/issues/2642> solved the real issue, and hence, upgrading `GitVersion.MsBuild` to `5.6.8` has the docker build pass.

Well, since <https://github.com/GitTools/GitVersion/issues/2634> is not solved yet, one needs a `GitVesion.yml` in the root folder for dotnet build to succeed.

## Build

```sh
$ dotnet publish GitVersionSysDrawingIssue/GitVersionSysDrawingIssue.csproj --configuration Release -o out/
$ docker build .
```
