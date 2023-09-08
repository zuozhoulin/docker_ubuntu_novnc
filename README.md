ubuntu+ros+novnc  
Docker version 24.0.5

基础镜像为 docker image [osrf/ros](https://hub.docker.com/r/osrf/ros)
    或无 ros ubuntu系统   [ubuntu] (https://hub.docker.com/_/ubuntu)
如仅想编译Ubuntu 16.04的镜像，修改对应基础镜像为 ubuntu:16.04 即可。
 note： 默认使用的官方源，部分库会因为网络问题build失败，多尝试几次看看。

* 已发布ros版本至docker hub： [zuozhoulin/novnc-ubuntu](https://hub.docker.com/r/zuozhoulin/novnc-ubuntu/tags) 

```
pull: docker push zuozhoulin/novnc-ubuntu:TAG  
run:  docker run  -dp  6080:6080   zuozhoulin/novnc-ubuntu:TAG
Browse:  http://localhost:6080/vnc.html 
还有一些环境变量见 entrypoint.sh， 并参考下述链接。 
```

参考资料
* DockerHub [theasp/novnc](https://hub.docker.com/r/theasp/novnc/)  &&   [dorowu/ubuntu-desktop-lxde-vnc](https://hub.docker.com/r/dorowu/ubuntu-desktop-lxde-vnc/)  
* GitHub [theasp/docker/novnc](https://github.com/theasp/docker)    &&  [fcwu/docker-ubuntu-vnc-desktop](https://github.com/fcwu/docker-ubuntu-vnc-desktop) 
