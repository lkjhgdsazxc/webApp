. venv/bin/activate
pip install -r requirements.txt
chmod 711 /home/ec2-user
supervisord -c gunicorn.conf 
sudo yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
rm -f /etc/nginx/nginx.conf
sudo cp /home/ec2-user/environment/webApp/nginx.conf /etc/nginx/
sudo nginx -t
sudo service nginx restart
sudo systemctl status nginx