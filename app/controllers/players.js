const Player = require('../models/player');

exports.getAll = function (req, res, next) {
    Player.find({}, (err, players) => {
        res.json(players);
    });
};

exports.getById = function (req, res, next) {
    Player.findById(req.params.id, (err, player) => {
        console.error(err);
        res.json(player);
    });
};

// exports.getPlayerByEmail = function (req, res, next) {
//     Player.findOne({ email: req.body.email }, function (err, player) {
//         res.json(player);
//     });
// };

exports.create = function (req, res, next) {
    let player = Player(req.body);
    player.save((err) => {
        res.json(err)
    });
};
