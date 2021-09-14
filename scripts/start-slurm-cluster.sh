# Replace munge.key with munge.key file used in calling slurm client(s)
sudo cp /tmp/munge.key /tmp/m.key
sudo chown munge:munge /tmp/m.key
sudo mv /tmp/m.key /etc/munge/munge.key
sudo chmod 400 /etc/munge/munge.key

# Restart munge service to load replacement munge.key
sudo service munge start

# Start and configure mysql database and slurm db interface
if [[ $(/bin/hostname -s) =~ "master" ]]; then
  sudo service mysql start
  sudo service slurmdbd start
  sudo mysql -u root < initialize-mariadb.sql
  # slurmctld -D
fi


# Start slurmd worker
#slurmd

# Sleep for 10 seconds to prevent race condition, then start slurmctld controller
#sleep 10
#slurmctld -D

# for testing
sleep 14000
