const Player = require('../models/player');

exports.getAll = (req, res) => {
    Player.find({}, (err, players) => {
        if (err) {
            res.status(500).json({
                error: {
                    status: 500,
                    message: 'Request could not be completed.',
                },
            });
        } else {
            res.json(players);
        }
    });
};

exports.getPlayerById = (id, callback) => {
    Player.findById(id, (err, player) => {
        if (err) {
            callback(err, null);
        } else {
            callback(null, player);
        }
    });
};


exports.getById = (req, res) => {
    Player.findById(req.params.id, (err, player) => {
        if (err) {
            res.status(404).json({
                error: {
                    status: 404,
                    message: 'Player not found.',
                },
            });
        } else {
            res.json(player);
        }
    });
};

exports.getPlayerByEmail = (req, callback) => {
    Player.findOne({ email: req.body.email }, (err, player) => {
        callback(err, player);
    });
};

exports.create = (req, res) => {
    const player = Player(req.body);
    player.save((err) => {
        if (err) {
            res.status(500).json({
                error: {
                    status: 500,
                    message: 'Request could not be completed.',
                },
            });
        } else {
            res.json(player);
        }
    });
};
