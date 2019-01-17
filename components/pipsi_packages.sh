echo "----> Installing PIPSI"

curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python3
PATH=/home/$USER/.local/bin:$PATH

echo "----> Installing from packages.txt"
while read package; do
    echo "**** Installing $package"
    pipsi uninstall -y "$package"
    pipsi install "$package"
done <pipsi_packages.txt