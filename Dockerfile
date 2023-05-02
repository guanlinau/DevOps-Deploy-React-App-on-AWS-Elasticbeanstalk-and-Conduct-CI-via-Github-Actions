FROM node:16 AS builder
WORKDIR ./app
COPY package*.json ./
RUN npm install
COPY ./ ./
RUN npm run build

FROM nginx
# The image needs nginx to run on aws
RUN apt-get update && apt-get install -y npm
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# Copy the content of the builder step, move the contents of build folder into the html folder in this nginx container
# That's where our app would run from in aws
# No need to specify a command to start nginx as it gets started by default when a container with the image starts