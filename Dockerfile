FROM node:latest

RUN curl -o- -L https://yarnpkg.com/install.sh | bash
ENV PATH="/root/.yarn/bin:/root/.config/yarn/global/node_modules/.bin:${PATH}"

RUN curl https://cli-assets.heroku.com/install.sh | sh

WORKDIR /app

COPY create-app.sh /app/create-app.sh
COPY destroy-app.sh /app/destroy-app.sh

COPY entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/create-app.sh
RUN chmod +x /app/destroy-app.sh

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
