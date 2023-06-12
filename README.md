# 3p-docker

WIP README

edit `einsteinium.conf` as needed

`sudo docker build -t emc .`

Initial launch:
`sudo ./launch-emc.sh`

Can access the rpc via `http://127.0.0.1:41879/` from the host, and p2p port will be bound to all interfaces on the host.

You can enter a shell within the container via `sudo docker exec -it emc bash` 

You can stop and start the container via
`sudo docker container stop emc`
`sudo docker container start emc`
