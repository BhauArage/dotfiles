#!/usr/bin/env zsh

<<<<<<< HEAD
# Note: This script is specific to my setup and might not be useful for others. This is being shared so as to be used as a reference if you want to mimic the same setup.

# You can run this script using this command:
# curl -fsSL https://raw.githubusercontent.com/vraravam/dotfiles/master/scripts/fresh-install-of-osx-custom.sh | zsh

# Note: Change these as per your settings
USERNAME="${USERNAME:-$(whoami)}"
KEYBASE_USERNAME="${KEYBASE_USERNAME:-"avijayr"}"
KEYBASE_HOME_REPO_NAME="${KEYBASE_HOME_REPO_NAME:-"home"}"
KEYBASE_PROFILES_REPO_NAME="${KEYBASE_PROFILES_REPO_NAME:-"profiles"}"
PERSONAL_PROFILES_DIR="${PERSONAL_PROFILES_DIR:-"${HOME}/personal/${USERNAME}/profiles"}"
PERSONAL_BIN_DIR="${PERSONAL_BIN_DIR:-"${HOME}/.bin"}"
PERSONAL_CONFIGS_DIR="${PERSONAL_CONFIGS_DIR:-"${HOME}/personal/dev"}"

# Load all zsh config files for PATH and other env vars to take effect
# Note: Can't run 'exec zsh' here - since the previous function definitions and PATH, etc will be lost in the sub-shell
load_zsh_configs
=======
# Note: This script is specific to my setup and might not useful for others. This is being shared so as to be used as a reference if you want to mimic the same setup.

# You can run this script using this command:
# curl -L https://raw.githubusercontent.com/vraravam/dotfiles/master/scripts/fresh-install-of-osx-custom.sh | zsh

# These env vars are duplicated intentionally since this script would bootstrap the installation
USERNAME="${USERNAME:-$(whoami)}"

# custom env var to enable logging only during the first installation process
FIRST_INSTALL=true
# load the PATH & utility functions and other aliases
source "${HOME}/.zprofile"
source "${HOME}/.aliases"
source "${HOME}/.shellrc"
>>>>>>> 2dbbf0c (Initial commit on Mon Jun 10 11:59:27 IST 2024)

#######################
# Clone the home repo #
#######################
<<<<<<< HEAD
echo "$(green "==> Cloning home repo")"
if [ ! -d "${HOME}/.git" ]; then
  rm -rf "${HOME}/tmp"
  mkdir -p "${HOME}/tmp"
  git clone keybase://private/${KEYBASE_USERNAME}/${KEYBASE_HOME_REPO_NAME} "${HOME}/tmp"
  mv "${HOME}/tmp/.git" "${HOME}/"
  rm -rf "${HOME}/tmp"

  # Checkout files (these should not have any modifications/conflicts with what is in the remote repo)
  git -C "${HOME}" checkout ".[a-zA-Z]*" personal

  # Reset ssh keys' permissions so that git doesn't complain when using them
  sudo chmod -R 600 "${HOME}"/.ssh/*

  # Fix /etc/hosts file to block facebook #
  sudo cp "${PERSONAL_BIN_DIR}/macos/etc.hosts" /etc/hosts
else
  warn "skipping cloning of home repo since a git repo is already present in '${HOME}'"
=======
echo "$(green "==> Loading home repo")"
if [ ! -d "${HOME}/.git" ]; then
  rm -rf "${HOME}/tmp"
  mkdir -p "${HOME}/tmp"
  git clone keybase://private/avijayr/home "${HOME}/tmp"
  mv "${HOME}/tmp/.git" "${HOME}/"
  rm -rf "${HOME}/tmp"

  ######################################################################################################
  # Checkout files (these should not have any modifications/conflicts with what is in the remote repo) #
  ######################################################################################################
  git -C "${HOME}" checkout ".[a-zA-Z]*" personal
else
  warn 'skipping cloning of home repo since its already present'
>>>>>>> 2dbbf0c (Initial commit on Mon Jun 10 11:59:27 IST 2024)
fi

###########################
# Clone the profiles repo #
###########################
<<<<<<< HEAD
echo "$(green "==> Cloning profiles repo")"
if [ ! -d "${PERSONAL_PROFILES_DIR}/.git" ]; then
  rm -rf "${PERSONAL_PROFILES_DIR}"
  git clone keybase://private/${KEYBASE_USERNAME}/${KEYBASE_PROFILES_REPO_NAME} "${PERSONAL_PROFILES_DIR}"
else
  warn "skipping cloning of profiles repo since a git repo is already present in '${PERSONAL_PROFILES_DIR}'"
fi

=======
echo "$(green "==> Loading profiles repo")"
PERSONAL_PROFILES_DIR="${PERSONAL_PROFILES_DIR:-"${HOME}/personal/${USERNAME}/profiles"}"
if [ ! -d "${PERSONAL_PROFILES_DIR}/.git" ]; then
  rm -rf "${PERSONAL_PROFILES_DIR}"
  git clone keybase://private/avijayr/profiles "${PERSONAL_PROFILES_DIR}"
else
  warn 'skipping cloning of profiles repo since its already present'
fi

#########################################
# Fix /etc/hosts file to block facebook #
#########################################
echo "$(green "==> Fixing hosts file")"
PERSONAL_BIN_DIR="${PERSONAL_BIN_DIR:-"${HOME}/.bin"}"
sudo cp "${PERSONAL_BIN_DIR}/macos/etc.hosts" /etc/hosts

############################################################################
# Reset ssh keys' permissions so that git doesn't complain when using them #
############################################################################
sudo chmod -R 600 "${HOME}"/.ssh/*

>>>>>>> 2dbbf0c (Initial commit on Mon Jun 10 11:59:27 IST 2024)
##################################################
# Resurrect repositories that I am interested in #
##################################################
echo "$(green "==> Resurrecting repos")"
<<<<<<< HEAD
=======
PERSONAL_CONFIGS_DIR="${PERSONAL_CONFIGS_DIR:-"${HOME}/personal/dev"}"
>>>>>>> 2dbbf0c (Initial commit on Mon Jun 10 11:59:27 IST 2024)
for file in $(ls "${PERSONAL_CONFIGS_DIR}"/repositories-*.yml); do
  resurrect-repositories.rb -r "${file}"
done

############################################################
# post-clone operations for installing system dependencies #
############################################################
echo "$(green "==> Running post-clone operations")"
all restore-mtime -c
allow_all_direnv_configs
install_mise_versions
<<<<<<< HEAD
rm -rf "${HOME}/.ssh/known_hosts.old"
=======
>>>>>>> 2dbbf0c (Initial commit on Mon Jun 10 11:59:27 IST 2024)

##################
# Install devbox #
##################
# curl -fsSL https://get.jetpack.io/devbox | bash
# mkdir -p ${HOME}/.config/devbox/lib/ && devbox completion zsh > ${HOME}/.config/devbox/lib/use_devbox.sh

##############################################
# Load the direnv config for the home folder #
##############################################
cd ..
cd -

###################################################################
# Restore the preferences from the older machine into the new one #
###################################################################
<<<<<<< HEAD
osx-defaults.sh -s
=======
osx-defaults.sh -y
>>>>>>> 2dbbf0c (Initial commit on Mon Jun 10 11:59:27 IST 2024)
capture-defaults.sh i

################################
# Recreate the zsh completions #
################################
rm -rf "${HOME}"/.zcompdump*; compinit

###################
# Setup cron jobs #
###################
<<<<<<< HEAD
command_exists recron
if [ $? -eq 0 ]; then
  recron
fi
=======
recron
>>>>>>> 2dbbf0c (Initial commit on Mon Jun 10 11:59:27 IST 2024)

# To install the latest versions of the hex, rebar and phoenix packages
# mix local.hex --force && mix local.rebar --force
# mix archive.install hex phx_new 1.4.1

# To install the native-image tool after graalvm is installed
# gu install native-image

# Enabling history for iex shell (might need to be done for each erl that is installed via mise)
# rm -rf tmp
# mkdir -p tmp
# cd tmp || exit
# git clone https://github.com/ferd/erlang-history.git
# cd erlang-history || exit
# sudo make install
# cd ../.. || exit
# rm -rf tmp

# vagrant plugin install vagrant-vbguest

# if installing jhipster for dot-net-core
# TODO: Use the next line since the released version is only for .net 2.2:
# npm i -g generator-jhipster-dotnetcore
# Note: '-g' didnt work. Had to do 'npm init' and then use '--save-dev' to install and link as a local dependency
# npm i -g jhipster/jhipster-dotnetcore
# npm link generator-jhipster-dotnetcore
# jhipster -d --blueprints dotnetcore

# Default tooling for dotnet projects
# dotnet tool install -g dotnet-sonarscanner
# dotnet tool install -g dotnet-format

echo "\n"
echo "$(green "********** Finished auto installation process: Please perform these manual steps **********")"
<<<<<<< HEAD
echo "$(red "1. Go to VSCodium > Command Palette (Cmd+Shift+P) > Sync: Download Settings")"
=======
echo "$(red "1. Go to VSCodium > Command Palette (Cmd+Shift+P) > Sync Settings: Download (repository -> user)")"
>>>>>>> 2dbbf0c (Initial commit on Mon Jun 10 11:59:27 IST 2024)
echo "$(red "2. Manually setup the Finder preferences for sidebar")"
echo "$(red "3. Login into iCloud and setup Desktop sync")"
echo "$(red "4. Login for Software Update to different ID (after iCloud login) for beta updates")"
