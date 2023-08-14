# Start your image with a node base image
FROM node:20-alpine

ENV NODE_ENV production

# The /app directory should act as the main application directory
WORKDIR /usr/app/src

# Copy the app package and package-lock.json file
COPY package*.json ./

# Copy local directories to the current local directory of our docker image (/app)
COPY ./src ./src
COPY ./public ./public

# Install node packages & build react
RUN npm install -g npm@latest \
    && rm -fr node_modules \
    && npm install -g serve \
    && npm install \
    && npm run build

EXPOSE 3000

# Start the app using serve command
CMD [ "serve", "-s", "build" ]