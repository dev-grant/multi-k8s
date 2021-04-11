docker build -t grantgolden/multi-client:latest -t grantgolden/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t grantgolden/multi-server:latest -t grantgolden/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t grantgolden/multi-worker:latest -t grantgolden/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push grantgolden/multi-client:latest
docker push grantgolden/multi-server:latest
docker push grantgolden/multi-worker:latest

docker push grantgolden/multi-client:$SHA
docker push grantgolden/multi-server:$SHA
docker push grantgolden/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=grantgolden/multi-server:$SHA
kubectl set image deployments/client-deployment client=grantgolden/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=grantgolden/multi-worker:$SHA