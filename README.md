# Cumulus Geolambda

This project uses both [cumulus-ecs-task-python](https://github.com/cumulus-nasa/cumulus-ecs-task-python) and [Geolambda](https://github.com/developmentseed/geolambda) to support geospatial lambdas (supporting gdal and numpy) in a Cumulus Workflow.

## Use

See [cumulus-ecs-task-python](https://github.com/cumulus-nasa/cumulus-ecs-task-python)

## Build & Push

```
export VERSION=0.0.1
docker build -t cumuluss/cumulus-geolambda:$VERSION .

# docker login
docker tag cumuluss/cumulus-geolambda:$VERSION cumuluss/cumulus-geolambda:$VERSION
docker push cumuluss/cumulus-geolambda:$VERSION
```

## Testing

```
docker run -it \
  -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  cumuluss/cumulus-geolambda:$VERSION \
  cumulus-ecs-task \
  --activityArn arn:aws:states:us-east-1:433612427488:activity:cce-DownloadTiles-Activity \
  --lambdaArn arn:aws:lambda:us-east-1:433612427488:function:cce-ViirsProcessing
```
