# Mac OS environment setup
## Brand new Mac
On a brand new Mac, there are no developer tools (make, git, xcode etc.) and hence we download zip file of this repo.
 * Download repo zip file.
 * Run Homebrew installer.
 * Delete non-git version and clone this repo again for subsequent changes.


        mkdir ~/gitpro
        cd ~/gitpro
        curl -L -o ~/gitpro/myterm.zip https://github.com/knowshan/myterm/archive/master.zip
        unzip myterm.zip
        mv myterm-master myterm
	cd myterm
        ./BrewInstall-764ecdc.rb
        cd ~
        rm -rf myterm
        git clone https://github.com/knowshan/myterm.git
        cd myterm
        make setup


## Make targets
	make
	setup-brew                     Setup Homebrew and install brew packages
	setup-py                       Python setup using pyenv
	setup                          Setup everything
	update-mac                     Install xcode CLI tools and updates
