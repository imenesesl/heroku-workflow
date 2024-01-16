FROM node:latest

RUN curl -o- -L https://yarnpkg.com/install.sh | bash
ENV PATH="/root/.yarn/bin:/root/.config/yarn/global/node_modules/.bin:${PATH}"

RUN if [ -n "$HEROKU_API_KEY" ]; then \
        curl https://cli-assets.heroku.com/install.sh | sh; \
    fi

WORKDIR /app

COPY create-app.sh /app/create-app.sh
COPY destroy-app.sh /app/destroy-app.sh
COPY update-version.sh /app/update-version.sh

COPY entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/create-app.sh
RUN chmod +x /app/destroy-app.sh
RUN chmod +x /app/update-version.sh

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
