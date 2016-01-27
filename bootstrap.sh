sudo yum update -y

sudo yum install -y bzip2 

sudo yum install -y http://yum.postgresql.org/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-2.noarch.rpm

## postgresql stuff
sudo yum install -y postgresql95-server postgresql95-contrib

sudo systemctl enable postgresql-9.5
