# Start your image with a node base image
FROM node:lts

# The /src directory should act as the main application directory
WORKDIR /src

# Copy the app package file
COPY package.json /src/package.json
COPY package-lock.json /src/package-lock.json

# Copy local directories to the current local directory of our docker image (/app)
COPY . /src

# Install node packages & build react
RUN npm install -g npm@latest \
    && rm -fr node_modules \
    && npm install -g serve \
    && npm ci \
    && npm run build

# Expose frontend
EXPOSE 8228

# Start the app using serve command
CMD [ "serve", "-s", "build" ]