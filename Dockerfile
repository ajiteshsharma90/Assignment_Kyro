FROM tiangolo/uwsgi-nginx-flask:python3.6


WORKDIR /cosmosdb-with-fastapi

RUN pip install fastapi
RUN pip install fastapi uvicorn
Run pip install python-dotenv
Run pip install aiohttp
Run pip install azure-cosmos

ADD . /cosmosdb-with-fastapi/

# ssh
ENV SSH_PASSWD "root:Docker!"
RUN apt-get update \
        && apt-get install -y --no-install-recommends dialog \
        && apt-get update \
 && apt-get install -y --no-install-recommends openssh-server \
 && echo "$SSH_PASSWD" | chpasswd 

COPY sshd_config /etc/ssh/
COPY init.sh /usr/local/bin/

RUN chmod u+x /usr/local/bin/init.sh
EXPOSE 8000 2222

#CMD ["python", "/code/manage.py", "runserver", "0.0.0.0:8000"]
ENTRYPOINT ["init.sh"]
