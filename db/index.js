const configDb = require('../config/database');
const mongoose = require('mongoose');
const debug = require('debug')('spinny:database');

let db = null;

module.exports = {
    connect: (connection = configDb.connection) => {
        return new Promise((resolve, reject) => {
            const options = {
                useNewUrlParser: true,
                useCreateIndex: true
            };
            mongoose.connect(connection, options).then(client => {
                debug('Connected to ' + client.connection.name);
                db = client;
                resolve(client);
            }, err => {
                console.log('MongoDB Connection Error. Please make sure that MongoDB is running.');
                reject(err);
            });
        });
    },
    disconnect: () => {
        return new Promise((resolve, reject) => {
            db.connection.close(() => {
                resolve();
            }, err => {
                reject(err);
            });
        });
    },
    drop: () => {
        return new Promise((resolve, reject) => {
            db.connection.dropDatabase(() => {
                resolve();
            }, err => {
                reject(err);
            });
        });
    }
};
