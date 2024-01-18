# ROS2 Docker How-To


This is a small example of how to use to docker with ros2. As an example, it includes the `cpp_pubsub` package from the ros2 tutorials. 


##  Build the container
From the root directory, run
```
docker compose build
```
This will run all the commands in the `Dockerfile`. 

## Launch the container
From the root directory, run
```
docker compose up -d
```
The `-d` flag allows the container to be created in detached mode, so that you can continue to use the same terminal

since the `./colcon_ws` folder has been mounted, anything you do inside that folder (either inside or outside the docker container) will be saved to your local computer. This makes it particularly easy to `git commit` things from outside the docker container, and to not loose any files. Note, this also means that anything saved outside of `/root/colcon_ws` inside the docker will not be saved when you stop and restart the docker container. 

## Enter into the container
To run commands into the container, you need to get a terminal into the container. 
```
docker exec -it <container_name> bash
```
where `<container_name>` can be found by running `docker ps`

You can run this command from multiple terminals.  Once you are inside the docker container, you can build your ros2 packages and environment for example:
```
cd /root/colcon_ws
colcon build --symlink-install
```

## Shutting down the container
From outside the container, from the root directory, run
```
docker compose down
```

Alternatively 
```
docker stop <container_id>
```

##  Modifications

If you want to install any new packages or libraries, dont forget to add that to the `Dockerfile` so it is available for the future. Ideally tag each installation with a specific version number. 

The `./colcon_ws` folder is mounted as a volume, so any changes inside that folder will also be reflected properly outside the docker. 


## Permissions
Due to the shared volume, the permissions can sometimes get a little complicated. Essentially any files you create inside the docker will belong to `root` which is an admin user. As such, either you can create a `user` account in the docker file, and then use `sudo` inside the docker, or you can change the permissions and owners of the files when necessary. The `chgrp` and `chown` Linux commands will likely be quite helpful. 

## Security
We have used `network_mode="host"` and `privileged=true` inside the `docker-compose.yaml` which is very bad practice from a security pov. If you care about this, look into the docker documentation on how to set up a `docker-compose.yaml` so you only expose the things you want to expose.


