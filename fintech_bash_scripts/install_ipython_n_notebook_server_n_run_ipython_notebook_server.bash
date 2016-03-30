# This line updates the repository(?) used
sudo apt-get update

# This line installs IYython notebook server
sudo apt-get -y install ipython3 ipython3-notebook

read -p 'Press and key to continue (control-c to quit without running ipython3 notebook server) : ' pause_var

# This line runs the server
sudo ipython3 notebook --ip=0.0.0.0 --port=8080 --no-browser --notebook-dir="$GOPATH/notebooks"

# ToDo : Script security outside of Cloud9 ...
