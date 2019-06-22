const Player = require('../models/player');

exports.getAll = function (req, res, next) {
    Player.find({}, (err, players) => {
        if (err) {
            res.status(500).json({
                error: {
                    status: 500,
                    message: 'Request could not be completed.'
                }
            });
        } else {
            res.json(players);
        }
    });
};

exports.getById = function (req, res, next) {
    Player.findById(req.params.id, (err, player) => {
        if (err) {
            res.status(404).json({
                error: {
                    status: 404,
                    message: 'Player not found.'
                }
            });
        } else {
            res.json(player);
        }
    });
};

// exports.getPlayerByEmail = function (req, res, next) {
//     Player.findOne({ email: req.body.email }, function (err, player) {
//         res.json(player);
//     });
// };

exports.create = function (req, res, next) {
    let player = Player(req.body);
    player.save(err => {
        if (err) {
            res.status(500).json({
                error: {
                    status: 500,
                    message: 'Request could not be completed.'
                }
            });
        } else {
            res.json(err);
        }
    });
};
