# QWTF Map Repo

Contains all known QWTF maps and their assets, as well as lits, locs and skins. If any are missing please submit a PR.


## Docker

### Build map-repo

```
docker build --tag=map-repo .
```


### Deploy map-repo

```
docker tag map-repo fortressone/map-repo:latest
docker push fortressone/map-repo:latest
```


## Compile for GitHub release

    ./build.sh


## Deploy

GitHub actions automatically syncs to S3. See `.github/workflows/workflow.yml`.
