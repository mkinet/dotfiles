# script to autoamtically configure ubuntu desktop after installation
# Now passwordless sudo for now...
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible

sudo ansible-pull -U https://github.com/<your_user_name>/<ansible-repo>.git
  

