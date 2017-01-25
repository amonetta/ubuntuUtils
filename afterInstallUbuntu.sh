# Author: Agustín I. Monetta 
# Last Update: 18/11/2016
# GitHub: https://github.com/monettagu/ubuntuUtils/
################################################
# Install common libs for users and developers #
################################################
### Fuente: http://howtoubuntu.org/things-to-do-after-installing-ubuntu-14-04-trusty-tahr#install-essentials

sudo apt --yes install aptitude curl git screen synaptic vlc gimp gimp-data gimp-plugin-registry gimp-data-extras y-ppa-manager bleachbit flashplugin-installer unace unrar zip unzip rar unrar p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller libxine1-ffmpeg mencoder flac faac faad sox ffmpeg2theora libmpeg2-4 uudeview libmpeg3-1 mpeg3-utils mpegdemux liba52-dev mpeg2dec vorbis-tools id3v2 mpg321 mpg123 libflac++6 totem-mozilla icedax lame libmad0 libjpeg-progs libdvdcss2 libdvdread4 libdvdnav4 libswscale-extra-2 ubuntu-restricted-extras screen memcached

##############################
# Instalar JDK and set java7 #
##############################
### Fuente: http://www.ubuntu-guia.com/2012/04/instalar-oracle-java-7-en-ubuntu-1204.html
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get --yes install oracle-java6-installer
echo | java -version

sudo apt-get --yes install oracle-java7-installer
echo | java -version

sudo apt-get --yes install oracle-java8-installer
echo | java -version

sudo update-java-alternatives -s java-7-oracle
sudo apt-get --yes install oracle-java7-set-default

###################################
# Install Chrome and Chromedriver #
###################################

sudo apt-get --yes install libxss1 libappindicator1 libindicator7
if [[ $(getconf LONG_BIT) = "64" ]]
then
	echo "64bit Detected" &&
	echo "Installing Google Chrome" &&
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &&
	sudo apt install google-chrome-stable_current_amd64.deb &&
	rm -f google-chrome-stable_current_amd64.deb
else
	echo "32bit Detected" &&
	echo "Installing Google Chrome" &&
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb &&
	sudo apt install google-chrome-stable_current_i386.deb &&
	rm -f google-chrome-stable_current_i386.deb
fi
# Ahora installar xvfb para correr Chrome headlessly
sudo apt-get install xvfb

# Check latest release for dirver at http://chromedriver.storage.googleapis.com/LATEST_RELEASE/
echo "Check latest release for dirver at http://chromedriver.storage.googleapis.com/LATEST_RELEASE/"
wget -N http://chromedriver.storage.googleapis.com/2.20/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
chmod +x chromedriver

sudo mv -f chromedriver /usr/local/share/chromedriver
sudo ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver
sudo ln -s /usr/local/share/chromedriver /usr/bin/chromedriver

# Instalar las dependencias de Python para Selenium

sudo apt-get --yes install python-pip

## (Optional) Create and enter a virtual environment:
# sudo apt-get install python-virtualenv
# virtualenv env


sudo pip install pyvirtualdisplay selenium pyOpenSSL

sudo cpan make install
sudo cpan install Bundle::CPAN
sudo cpan install HTTP::Request
sudo cpan install LWP::UserAgent
sudo cpan install LWP::Protocol::https

############################
# Video codecs for firefox #
############################
### Fuente: http://www.webupd8.org/2014/04/10-things-to-do-after-installing-ubuntu.html

sudo add-apt-repository ppa:mc3man/trusty-media
sudo apt-get update
sudo apt-get --yes install gstreamer0.10-ffmpeg

#########################
# Install Skype and fix #
#########################
sudo apt-get --yes install skype
## Fix Skype not using the correct system theme on 64bit
sudo apt-get --yes install gtk2-engines-murrine:i386 gtk2-engines-pixbuf:i386

##################
# Install sdkman #
##################

echo "Installing sdkman..."
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

echo "sdkman installed, now install grails."
echo "Also install nvm (https://github.com/creationix/nvm) and node 0.12.5"

##################
# Install mysql  #
##################

echo "Preparing for install mysql sever"
## Cleaning from before installations
sudo rm /etc/mysql/my.cnf
sudo rm /etc/alternatives/my.cnf
sudo rm /etc/mysql/debian.cnf
sudo rm -rf /var/lib/mysql*
sudo rm -rf /etc/mysql/mysql.conf.d/
sudo apt-get remove --purge mysql-server mysql-server-* mysql-server-core-* mysql-client mysql-client-* mysql-client-core-* mysql-common apparmor
sudo apt-get autoremove
sudo apt-get autoclean

echo "Install mysql server and workbench"
sudo apt-get install -y mysql-common
sudo apt-get install -y mysql-server
sudo apt-get install -y mysql-workbench

##################
# Clean up setup #
##################

echo "Cleaning Up" &&
sudo apt-get -f install &&
sudo apt-get autoremove &&
sudo apt-get --yes autoclean &&
sudo apt-get --yes clean
