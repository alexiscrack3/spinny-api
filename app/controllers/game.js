const Game = require('../models/game');

exports.create = (body) => {
    if (body.winner !== body.loser) {
        return Game.create(body);
    }
    return Promise.reject(new Error('Winner and loser cannot be same player'));
};

exports.deleteById = id => new Promise((resolve, reject) => {
    Game.findOneAndRemove({ _id: id }, (err, game) => {
        if (err) {
            reject(err);
        } else if (game) {
            resolve(game);
        } else {
            reject(new Error('Game id does not exist'));
        }
    });
});

exports.getAll = () => Game.find({})
    .populate('winner')
    .populate('loser')
    .exec();
