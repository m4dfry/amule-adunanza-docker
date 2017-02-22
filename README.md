```
              ,-.,-.
               \ \\ \
                \ \\_\
                /     \
             __|    a a|
           /`   `'. = y)=
         /        `"`}
       _|    \       }
       { \     ),   //      .             
        '-',  /__\ ( (     ==            
          (______)\_)_)   ===            
       /""""""""""""""""\___/ ===        
  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~   
       \______ o          __/            
         \    \        __/             
          \____\______/    
```
# aMule AdunanzA Daemon container, by M4dFry
## A complete aMule server for Fastweb users

Complete and stable aMule AdunanzA daemon installation
 - *Running on Debian:wheezy-slim*
 - *aMule version 2.3.1*
 - *No webserver included at this moment (Webserver tends to crash a lot)*
 - *If there are users interested, it can be a next step to include the webserver with a more stable skin.*

### General instructions

Docker uses three folder
 - **config** 
 - **finished**
 - **incomplete**
 
While finished and config are self explanatory, a couple of words are needed for the config folder.
When the program runs, it checks the presence of amule.conf and adunanza.conf.
If they're not present, the program copy the default version of these two files from the config folder inside the docker.
Then being a first run, it creates all the .met and .dat file for credits, nodes, etc.
Else, if the program find an amule.conf and adunanza.conf, it tries to use them, also reusing present .met and .dat files, so that credits, cache and kad nodes are preserved.

The default file are the default configuration for amule 2.3.1 and the default adunanza.conf, with the following fixes recommended by Adunanza Forum
 - https://forum.adunanza.net/t/fix-temporaneo-per-server-met-e-nodes-dat-su-amule-adunanza-mac-e-linux/8589
 - https://forum.adunanza.net/t/fix-temporaneo-update-adunanza-net-per-amule-adunanza-linux-mac-adu-remote-conf-ha-risposto-404-errore-6/9335

Stardard ports are used (4662,4672), Kad enabled, uPnP disabled, EC password set to amule

### Command line

Container can be run using 

```
docker run \
--net=host \ 
--volume "<your config folder>:/config" \
--volume "<where to put your finished files>:/finished" \
--volume "<where to keep your incomplete files>:/incomplete" \
m4dfry/amule-adunanza
```

### Integration with SystemD - Unit file

If your system uses systemd, you can save the following in a .service file and enable to run at boot.
This unit starts the daemon after rpcbind (since the daemon uses a NFS share).
Paths are just examples based on a LibreElec installation, you have to replace them with your own folders

```
[Unit]
Description=%p container
Requires=service.system.docker.service
After=service.system.docker.service rpcbind.service

[Service]
TimeoutStartSec=0
ExecStart=/storage/.kodi/addons/service.system.docker/bin/docker run \
--rm \
--name=%p \
--net=host \                                       ->  necessary for port forwarding from your router to the host that runs docker
--volume "/storage/NAS/Amule/.aMule:/config" \     ->  substitute with your config folder 
--volume "/storage/NAS/Amule:/finished" \          ->  substitute with your finished folder
--volume "/storage/NAS/Amule/Temp:/incomplete" \   ->  substitute with your incomplete folder
m4dfry/amule-adunanza

ExecStop=/storage/.kodi/addons/service.system.docker/bin/docker stop %p

[Install]
WantedBy=multi-user.target
```

More information on files used in this build: 
```
Package Name | Link | MD5
------------ | ------|-------
libwxbase2.8-0_2.8.12.1+dfsg-2ubuntu2_amd64.deb | [LINK](http://packages.ubuntu.com/trusty/amd64/libwxbase2.8-0/download) | 3dbc38cdde80c01059fbf6727f715d71
amule-adunanza-daemon_2012.1+2.3.1~dfsg1-0ubuntu1_amd64.deb | [LINK](http://packages.ubuntu.com/trusty/amd64/amule-adunanza-daemon/download) | 1e57d9ca3ae90c68d1ea49aa61b6da10
```
