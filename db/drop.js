/* eslint-disable no-console */
/* eslint-disable import/no-extraneous-dependencies */
const async = require('async');
const database = require('../db');

async.series([
    (callback) => {
        database.connect()
            .then(() => database.drop())
            .then(() => database.disconnect())
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
