#pouzitie existujuceho docker imaginu
FROM alpine

#stiahnutie a instalovanie dalsich potrebnych servisov
RUN apk add --update redis
RUN apk add --update gcc

#co ma imagine robit po startovani ako container
CMD ["redis-server"]