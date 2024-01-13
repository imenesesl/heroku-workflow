FROM node:latest

RUN curl -o- -L https://yarnpkg.com/install.sh | bash
ENV PATH="/root/.yarn/bin:/root/.config/yarn/global/node_modules/.bin:${PATH}"

RUN npm install -g heroku

WORKDIR /app

COPY create-app.sh /app/create-app.sh
COPY destroy-app.sh /app/destroy-app.sh
COPY deploy-app.sh /app/deploy-app.sh
COPY entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/create-app.sh
RUN chmod +x /app/destroy-app.sh
RUN chmod +x /app/deploy-app.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
