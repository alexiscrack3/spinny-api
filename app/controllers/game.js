const Game = require('../models/game');

exports.create = (body) => {
    const game = Game(body);
    return game.save();
};

exports.getAll = () => Game.find({})
    .populate('winner')
    .populate('loser')
    .exec();
