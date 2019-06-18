const async = require('async');
const path = require('path');
const fs = require('fs');
const database = require('../db');
const configDb = require('../config/database');

async.series([
    function (callback) {
        database.connect().then(() => {
            return database.drop();
        }).then(() => {
            return database.disconnect();
        }).then(() => {
            callback(null, 'Dropped database');
        }).catch(err => {
            console.error(err);
            process.exit(0);
        });
    }, function (callback) {
        database.connect().then(() => {
            callback(null, 'Database connection established');
        });
    }, function (callback) {
        const seedsPath = path.join(__dirname, configDb.seeds.directory);
        fs.readdir(seedsPath, function (err, files) {
            if (err) { callback(err, 'Error on seeds path'); }

            async.eachSeries(files, function (file, fileCallback) {
                const objects = require(seedsPath + '/' + file);
                console.log('Populating database with %s objects from %s', objects.length, file);
                async.eachSeries(objects, function (object, objectSavedCallBack) {
                    object.save().then(() => {
                        objectSavedCallBack();
                    }, err => {
                        callback(err, 'Error creating ', object);
                    });
                }, function (err) {
                    if (err) {
                        callback(err, 'Error seeding ' + file);
                    }
                    fileCallback();
                });
            }, function (err) {
                if (err) {
                    callback(err, 'Error seeding database');
                }
                callback(null, 'Seeded database');
            });
        });
    }
], function (err, results) {
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
