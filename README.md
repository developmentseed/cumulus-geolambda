# Cumulus Geolambda

This project uses both [cumulus-ecs-task-python](https://github.com/cumulus-nasa/cumulus-ecs-task-python) and [Geolambda](https://github.com/developmentseed/geolambda) to support geospatial lambdas (supporting gdal and numpy) in a Cumulus Workflow.

## Use


## Build

```
export VERSION=0.0.0
docker build -t cumuluss/cumulus-geolambda:$VERSION .

# docker login
docker tag cumuluss/cumulus-geolambda:$VERSION cumuluss/cumulus-geolambda:$VERSION
docker push cumuluss/cumulus-geolambda:$VERSION
```

