FROM python:3.6

WORKDIR /fype03
COPY requirements.txt .

RUN apt-get update \ 
    && apt install -y nginx supervisor \
    && pip install -r requirements.txt
    
COPY . .
    
# Nginx
RUN rm /etc/nginx/sites-enabled/default
COPY nginx_docker.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/nginx_docker.conf /etc/nginx/sites-enabled/nginx_docker.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Supervisord
RUN mkdir -p /var/log/supervisor
COPY supervisor_docker.conf /etc/supervisor/conf.d/supervisor_docker.conf

# Run the server
CMD ["/usr/bin/supervisord"]