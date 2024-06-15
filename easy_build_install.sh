REPODIR="$(cd "$(dirname "$0")"; pwd -P)"
cd "$REPODIR"

git submodule update --init
cd neovim

read -p "Update to latest commit of neovim? " confirm
if [[ "$confirm" == [yY] || "$config" == [yY][eE][sS] ]]; then
    echo "Pulling latest commit from GitHub."
    git checkout -d origin/master
fi

logfile="../ebi_$(date -u +%FT%H-%M-%SZ)_"

echo "Cleaning past build files."
make distclean >"${logfile}clean.log"

echo "Building dependencies."
make deps >"${logfile}dependencies.log"

echo "Building application."
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    make CMAKE_BUILD_TYPE=RelWithDebInfo >"${logfile}make.log"
else
    make CMAKE_BUILD_TYPE=Release >"${logfile}make.log"
fi

echo "Install application for system-wide use."
sudo make install >"${logfile}setup.log"
