FROM node:17 as development

WORKDIR /usr/src/app

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY . .

RUN npm install

ENTRYPOINT ["/entrypoint.sh"]

CMD ["npm", "run", "dev"]

FROM nginx:1.21 as production

COPY --from=development /usr/src/app/dist /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
