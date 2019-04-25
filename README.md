# QWTF Map Repo

Contains all known QWTF maps and their assets, as well as lits, locs and skins. If any are missing please submit a PR.


## Compile for GitHub release

```
$ zip -r map-repo.zip fortress/
```


## Deploy

You will need the credentials for the storage user on the zel+storage AWS account.

```
$ aws configure
$ aws s3 sync . s3://map-repo --exclude ".git/*" --exclude tags --exclude README.md --dryrun
```
