class PlayersRepository {
    constructor(player) {
        this.player = player;
    }

    create(body) {
        return this.player.create(body);
    }

    updateById(id, body) {
        return this.player.findByIdAndUpdate(id, body, { new: true });
    }

    getById(id) {
        return this.player.findById(id);
    }

    getByEmail(email) {
        return this.player.findOne({ email });
    }

    getAll(limit, skip) {
        return this.player
            .find()
            .skip(skip * 1)
            .limit(limit * 1);
    }
}

module.exports = PlayersRepository;
