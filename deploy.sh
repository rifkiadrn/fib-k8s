docker build -t rifkiadrn/multi-client:latest -t rifkiadrn/multi-client:$SHA ./client
docker build -t rifkiadrn/multi-server:latest -t rifkiadrn/multi-server:$SHA ./server
docker build -t rifkiadrn/multi-worker:latest -t rifkiadrn/multi-worker:$SHA ./worker

docker push rifkiadrn/multi-client:latest
docker push rifkiadrn/multi-server:latest
docker push rifkiadrn/multi-worker:latest

docker push rifkiadrn/multi-client:$SHA
docker push rifkiadrn/multi-server:$SHA
docker push rifkiadrn/multi-worker:$SHA

kubectl apply -f ./k8s
kubectl set image deployments/server-deployment server=rifkiadrn/multi-server:$SHA
kubectl set image deployments/client-deployment client=rifkiadrn/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rifkiadrn/multi-worker:$SHA
