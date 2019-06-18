const User = require('../models/user');

exports.getUsers = function (callback) {
    User.find({}, callback);
};

exports.getUserByEmail = function (email, callback) {
    User.findOne({ email: email }, function (err, user) {
        callback(err, user);
    });
};

exports.create = function (user, callback) {
    user.save(function (err) {
        callback(err);
    });
};

exports.getById = function (id, callback) {
    User.findById(id, function (err, user) {
        callback(err, user);
    });
};
