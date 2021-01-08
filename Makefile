ROOT_DIR=/home/<CHANGEME>
CONFIG_DIR=/home/<CHANGEME>/backup-config

SOURCE=/dev/sdb 
TARGET=/mnt/disks/sdb

CLEAN_TABETS=Package.list \
        Repo.keys \
        sources.list \
        sources.list.d

help:
        @echo make versions
        @echo make mount
        @echo make cd
        @echo make backup-config
        @echo make clean

versions:
        @echo python3 -V `python3 -V`
        @echo pip3 -V ` pip3 -V`

mount:
        sudo mount -o discard,defaults $(SOURCE) $(TARGET)

cd:
        cd $(TARGET)

backup-config: clean
        mkdir $(CONFIG_DIR)
        dpkg --get-selections > $(CONFIG_DIR)/Package.list
        sudo cp -R /etc/apt/sources.list* $(CONFIG_DIR)
        sudo apt-key exportall > $(CONFIG_DIR)/Repo.keys
        rsync --progress /home/`whoami` $(CONFIG_DIR)

clean:
        sudo rm -fr $(CONFIG_DIR)
