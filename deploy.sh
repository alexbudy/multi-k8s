docker build -t alexbudy/multi-client:latest -t alexbudy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alexbudy/multi-server:latest -t alexbudy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alexbudy/multi-worker:latest -t alexbudy/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alexbudy/multi-client:latest
docker push alexbudy/multi-server:latest
docker push alexbudy/multi-worker:latest

docker push alexbudy/multi-client:$SHA
docker push alexbudy/multi-server:$SHA
docker push alexbudy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alexbudy/multi-server:$SHA
kubectl set image deployments/client-deployment client=alexbudy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alexbudy/multi-worker:$SHA
