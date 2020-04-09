const mongoose = require('mongoose');
const debug = require('debug')('spinny:database');

let db = null;

function buildConnString() {
    let connString = 'mongodb://';
    if (process.env.DB_USER && process.env.DB_PASS) {
        connString += `${process.env.DB_USER}:${process.env.DB_PASS}@`;
    }
    connString += process.env.DB_HOST;
    if (process.env.DB_PORT) {
        connString += `:${process.env.DB_PORT}`;
    }
    connString += `/${process.env.DB_NAME}`;
    return connString;
}

module.exports = {
    connect: (connection = buildConnString()) => new Promise((resolve, reject) => {
        const options = {
            useNewUrlParser: true,
            useFindAndModify: false,
            useCreateIndex: true,
            useUnifiedTopology: true,
        };
        mongoose.connect(connection, options).then((client) => {
            debug(`Connected to ${client.connection.name}`);
            db = client;
            resolve(client);
        }, (err) => {
            debug('MongoDB Connection Error. Please make sure that MongoDB is running.');
            reject(err);
        });
    }),
    disconnect: () => new Promise((resolve, reject) => {
        db.connection.close(() => {
            resolve();
        }, (err) => {
            reject(err);
        });
    }),
    drop: () => new Promise((resolve, reject) => {
        db.connection.dropDatabase(() => {
            resolve();
        }, (err) => {
            reject(err);
        });
    }),
};
