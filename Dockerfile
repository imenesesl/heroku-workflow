FROM node:latest

RUN npm install -g heroku

WORKDIR /app

COPY create-app.sh /app/create-app.sh
COPY destroy-app.sh /app/destroy-app.sh
COPY entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/create-app.sh
RUN chmod +x /app/destroy-app.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]