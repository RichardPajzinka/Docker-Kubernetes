# specify base imagu
FROM node:14-alpine

#Install depenendecies
#copy all files from directory inside to container
COPY ./ ./
RUN npm install

#default command
CMD ["npm", "start"]