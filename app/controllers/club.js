const Club = require('../models/club');

exports.create = body => Club.create(body);

exports.getAll = () => Club.find();

exports.addPlayer = (id, playerId) => new Promise((resolve, reject) => {
    Club.update(
        { _id: id, members: { $nin: playerId } },
        { $push: { members: playerId } },
        (err, result) => {
            if (err) {
                reject(err);
            } else if (result.nModified > 0) {
                resolve();
            } else {
                reject(new Error('Player was not added to the club'));
            }
        },
    );
});

