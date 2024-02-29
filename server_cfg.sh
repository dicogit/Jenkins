sudo yum install java -y
sudo yum install git -y
sudo yum install maven -y


if [ -d "Jenkins" ];
then
    echo "repo is cloned and exists"
else
    git clone https://github.com/dicogit/Jenkins.git
fi

cd /home/ec2-user/Jenkins
git pull origin jenkins-1
git checkout jenkins-1
mvn package

