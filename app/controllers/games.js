class GamesController {
    constructor(game) {
        this.game = game;
    }

    create(body) {
        if (body.winner !== body.loser) {
            return this.game.create(body);
        }
        return Promise.reject(new Error('Winner and loser cannot be same player'));
    }

    deleteById(id) {
        return new Promise((resolve, reject) => {
            this.game.findOneAndRemove({ _id: id }, (err, game) => {
                if (err) {
                    reject(err);
                } else if (game) {
                    resolve(game);
                } else {
                    reject(new Error('Game id does not exist'));
                }
            });
        });
    }

    getAll() {
        return this.game
            .find()
            .populate('winner')
            .populate('loser')
            .exec();
    }
}

module.exports = GamesController;
