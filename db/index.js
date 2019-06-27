const mongoose = require('mongoose');
const debug = require('debug')('spinny:database');

let db = null;

module.exports = {
    connect: (connection = process.env.MONGODB_URI) => new Promise((resolve, reject) => {
        const options = {
            useNewUrlParser: true,
            useCreateIndex: true,
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
