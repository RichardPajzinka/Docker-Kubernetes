const express = require('express');
const redis = require('redis');
const process = require('process')

const app = express();
const client = redis.createClient({
    //host: 'https://my-redis-server.com'
    host: 'redis-server',
    //defualt 6379
    port: 6379
});
client.set('visits', 0);

app.get('/', (req, res) => {
    //process.exit(0);
    client.get('visits', (err,visits) => {
        res.send('Number of visits is ' + visits);
        client.set('visits', parseInt(visits) + 1);
    });
});

app.listen(8081, () => {
    console.log('Listening on port 4001');
});