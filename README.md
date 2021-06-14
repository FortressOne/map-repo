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

```
./build.sh
```


## Compile fortress/pk3 to gz archives in fortress/maps

```
./gzip.sh
```


## Deploy

GitHub actions automatically syncs to S3. See `.github/workflows/workflow.yml`.


## PK3 map file structure

```
pk3/<mapname>/
	lits/<mapname>.lit
	locs/<mapname>.loc
	maps/
		<mapname>.bsp
		<mapname>.ent
		<mapname>.rtlights
	progs/*.(mdl|bsp)
	sound/*.wav
	textures/
		<mapname>/*.(png|jpg)
		levelshots/<mapname>.(png|jpg)
    <mapname>.txt
```
