# specify base imagu
FROM node:14-alpine

# any following command will be executed relative to this path in the container
WORKDIR /usr/app

#Install depenendecies
#copy all files from directory inside to container
COPY ./package.json ./
RUN npm install
COPY ./ ./

#default command
CMD ["npm", "start"]