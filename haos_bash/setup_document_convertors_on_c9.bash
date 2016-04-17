:<<EOL
EOL
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install pandoc
git clone https://github.com/euske/pdfminer.git
cd pdfminer
sudo make cmap
sudo python setup.py install
sudo apt-get install -y poppler-utils
wget http://aufbix.org/~bolek/download/guide1.pdf
pdftotext guide1.pdf guide1.txt
python pdf-to-markdown/main.py guide1.pdf
