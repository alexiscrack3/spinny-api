class ClubsController {
    constructor(club) {
        this.club = club;
    }

    create(body) {
        return this.club.create(body);
    }

    getAll() {
        return this.club.find();
    }

    getAllByPlayerId(playerId) {
        return this.club.find({ members: { $in: [playerId] } })
            .populate({
                path: 'members',
                select: 'email',
                // select: 'email -_id',
            })
            .exec();
    }

    addPlayer(id, playerId) {
        return new Promise((resolve, reject) => {
            this.club.update(
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
    }
}

module.exports = ClubsController;
