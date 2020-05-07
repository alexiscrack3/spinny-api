const Game = require('../models/game');

exports.create = (body) => {
    if (body.winner !== body.loser) {
        return Game.create(body);
    }
    return Promise.reject(new Error('Winner and loser cannot be same player'));
};

exports.getAll = () => Game.find({})
    .populate('winner')
    .populate('loser')
    .exec();
