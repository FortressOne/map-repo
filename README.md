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


## Append map assets zip to bsp for clients that support this (FTE)

```
./package_bsps.sh
```


## Deploy

GitHub actions automatically syncs to S3. See `.github/workflows/workflow.yml`.


## Package map file structure

.gz maps are a .bsp concatenated with a .pk3 file, gzipped. pk3 files are shaped like this:

```
<mapname>.pk3
	lits/<mapname>.lit
	locs/<mapname>.loc
	maps/
		<mapname>.ent
		<mapname>.rtlights
	progs/*.(mdl|bsp)
	sound/*.wav
	textures/
		<mapname>/*.(png|jpg)
		levelshots/<mapname>.(png|jpg)
    <mapname>.txt
```
