#!/bin/bash
yum update -y
amazon-linux-extras install -y nginx1
systemctl enable nginx
systemctl start nginx
chmod 711 /home/ec2-user
git clone -b test-fyp3 https://github.com/lkjhgdsazxc/webApp.git
cd webApp/
. venv/bin/activate
pip install -r requirements.txt
cp /home/ec2-user/environment/webApp/supervisord.service /etc/systemd/system/
systemctl start supervisord.service
rm -f /etc/nginx/nginx.conf
cp /home/ec2-user/environment/webApp/nginx.conf /etc/nginx/
nginx -t
service nginx restart
curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.rpm.sh | sudo bash
yum install -y crowdsec
rm -f /etc/crowdsec/config.yaml
rm -f /etc/crowdsec/local_api_credentials.yaml
cp /home/ec2-user/environment/webApp/config.yaml /etc/crowdsec/
cp /home/ec2-user/environment/webApp/local_api_credentials.yaml  /etc/crowdsec/
systemctl restart crowdsec
yum install -y crowdsec-firewall-bouncer-iptables
