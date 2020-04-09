/* eslint-disable no-console */
/* eslint-disable import/no-extraneous-dependencies */
const dotenv = require('dotenv').config(); // eslint-disable-line no-unused-vars
const async = require('async');
const database = require('../db');

async.series([
    (callback) => {
        database.connect()
            .then(() => database.dropDatabase())
            .then(() => database.close())
            .then(() => {
                callback(null, 'Dropped database');
            })
            .catch((err) => {
                console.error(err);
                process.exit(0);
            });
    },
], (err, results) => {
    console.log('\n--- Database seed progam completed ---');

    if (err) {
        console.log('Errors = ');
        console.error(err);
    } else {
        console.log('Results = ');
        console.log(results);
    }
    console.log('\n--- Exiting database seed progam ---');

    process.exit(0);
});
