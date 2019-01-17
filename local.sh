# echo "»»» Syncing software install binaries from main workstation"
# rsync -e ssh -vzrPp janusz@hagrid.local:/data/$USER/Pobrane/software /data/$USER/Pobrane/software

PACKAGES_SOURCE=/data/$USER/Pobrane/packages

echo "»»» Install binaries from $PACKAGES_SOURCE"
mkdir -p $PACKAGES_SOURCE
for i in $PACKAGES_SOURCE/*.deb; do
    echo "**** Installing $i"
    sudo gdebi -n $i
done
