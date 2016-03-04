[![Build
Status](https://travis-ci.org/stevenpollack/conda-r.svg?branch=master)](https://travis-ci.org/stevenpollack/conda-r)

## Testing
If you want to make sure the build not only installs `RPostgres`
but that it works, you can use jamesbrink's 
[postgres](https://github.com/jamesbrink/docker-postgres)
container (see the [.travis.yml](.travis.yml)):
```bash
# start an instance of postgres server
docker run -P --name postgres -e USER=travis -e PASSWORD=swordfish -d jamesbrink/postgres
# start a linked instance of conda-r
docker run -it --link postgres:db stevenpollack/conda-r Rscript test_Rpostgres.R
``` 
