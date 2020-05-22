class PlayersController {
    constructor(player) {
        this.player = player;
    }

    create(body) {
        return this.player.create(body);
    }

    getById(id) {
        return this.player.findById(id);
    }

    getByEmail(email) {
        return this.player.findOne({ email });
    }

    getAll() {
        return this.player.find();
    }
}

module.exports = PlayersController;
