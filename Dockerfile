FROM python:3.9

WORKDIR /app/backend

COPY requirements.txt /app/backend

RUN apt-get update \
    && apt-get install -y \
       gcc \
       default-libmysqlclient-dev \
       default-mysql-client \
    && rm -rf /var/lib/apt/lists/*

RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/backend
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8000
