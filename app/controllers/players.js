const Player = require('../models/player');

exports.getPlayers = function (callback) {
    Player.find({}, callback);
};

exports.getPlayerByEmail = function (email, callback) {
    Player.findOne({ email: email }, function (err, player) {
        callback(err, player);
    });
};

exports.create = function (player, callback) {
    player.save(function (err) {
        callback(err);
    });
};

exports.getById = function (id, callback) {
    Player.findById(id, function (err, player) {
        callback(err, player);
    });
};
