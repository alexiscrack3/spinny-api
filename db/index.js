const mongoose = require('mongoose');
const { ConnectionString } = require('mongo-connection-string');
const debug = require('debug')('spinny:database');

let db = null;

function getConnetionString() {
    const connectionString = new ConnectionString({
        protocol: 'mongodb://',
        username: process.env.MONGO_USERNAME,
        password: process.env.MONGO_PASSWORD,
        hosts: [{
            host: process.env.MONGO_HOSTNAME,
            port: process.env.MONGO_PORT,
        }],
        database: process.env.MONGO_DB,
    });
    return connectionString.toURI();
}

module.exports = {
    connect: (uris = getConnetionString()) => new Promise((resolve, reject) => {
        const options = {
            useNewUrlParser: true,
            useFindAndModify: false,
            useCreateIndex: true,
            useUnifiedTopology: true,
        };
        mongoose.connect(uris, options).then((client) => {
            debug(`Connected to ${uris}`);
            db = client;
            resolve(client);
        }, (err) => {
            debug('MongoDB Connection Error. Please make sure that MongoDB is running.');
            reject(err);
        });
        mongoose.connection.on('disconnected', () => {
            debug(`Disconnected from ${getConnetionString()}`);
        });
    }),
    close: () => new Promise((resolve, reject) => {
        db.connection.close(() => {
            resolve();
        }, (err) => {
            reject(err);
        });
    }),
    dropDatabase: () => new Promise((resolve, reject) => {
        db.connection.dropDatabase(() => {
            resolve();
        }, (err) => {
            reject(err);
        });
    }),
};
