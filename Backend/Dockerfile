# Start your image with a node base image
FROM node:lts

# The /src directrory should act as the main application directory
WORKDIR /src

# Copy the server package file
COPY package.json /src/package.json
COPY package-lock.json /src/package-lock.json
RUN npm ci

# check every 30s to ensure this service returns HTTP 200
HEALTHCHECK --interval=30s \
  CMD node healthcheck.js

# copy in our source code last, as it changes the most
COPY . /src

# Expose backend
EXPOSE 8080

# Start the server
CMD [ "node", "src/index.js" ]