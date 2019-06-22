const Game = require('../models/game');

exports.create = (req, res) => {
    const game = Game(req.body);
    game.save((err) => {
        if (err) {
            res.status(500).json({
                error: {
                    status: 500,
                    message: 'Request could not be completed.',
                },
            });
        } else {
            res.json(game);
        }
    });
};

exports.getAll = (req, res) => {
    Game.find({})
        .populate('winner')
        .populate('looser')
        .exec((err, games) => {
            if (err) {
                res.status(500).json({
                    error: {
                        status: 500,
                        message: 'Request could not be completed.',
                    },
                });
            } else {
                res.json(games);
            }
        });
};
