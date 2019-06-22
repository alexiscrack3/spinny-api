/* eslint-disable no-console */
/* eslint-disable import/no-extraneous-dependencies */
const async = require('async');
const path = require('path');
const fs = require('fs');
const database = require('../db');
const configDb = require('../config/database');

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
    }, (callback) => {
        database.connect()
            .then(() => {
                callback(null, 'Database connection established');
            });
    }, (callback) => {
        const seedsPath = path.join(__dirname, configDb.seeds.directory);
        const files = fs.readdirSync(seedsPath);
        async.eachSeries(files, (file, fileCallback) => {
            const filePath = `${seedsPath}${'/'}${file}`;
            const objects = require(filePath);
            console.log('Populating database with %s objects from %s', objects.length, file);
            async.eachSeries(objects, (object, objectSavedCallBack) => {
                object.save().then(() => {
                    objectSavedCallBack();
                }, (err) => {
                    callback(err, 'Error creating ', object);
                });
            }, (err) => {
                if (err) {
                    callback(err, `Error seeding ${file}`);
                }
                fileCallback();
            });
        }, (err) => {
            if (err) {
                callback(err, 'Error seeding database');
            }
            callback(null, 'Seeded database');
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
