docker build -t ickyblindman/complex-client:latest -t ickyblindman/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t ickyblindman/complex-server:latest -t ickyblindman/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t ickyblindman/complex-worker:latest -t ickyblindman/complex-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ickyblindman/complex-client:latest
docker push ickyblindman/complex-server:latest
docker push ickyblindman/complex-worker:latest

docker push ickyblindman/complex-client:$SHA
docker push ickyblindman/complex-server:$SHA
docker push ickyblindman/complex-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ickyblindman/complex-server:$SHA
kubectl set image deployments/client-deployemnt client=ickyblindman/complex-client:$SHA
kubectl set image deployments/worker-deployment worker=ickyblindman/complex-worker:$SHA