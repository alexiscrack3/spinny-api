class PlayerRoutes {
    constructor(playersController) {
        this.playersController = playersController;
    }

    getAll(req, res) {
        this.playersController.getAll()
            .then((players) => {
                res.json({
                    data: players,
                });
            })
            .catch(() => {
                res.status(500).json({
                    error: {
                        status: 500,
                        message: 'Request could not be completed.',
                    },
                });
            });
    }

    getProfile(req, res) {
        this.playersController.getById(req.user.id)
            .then((player) => {
                res.json({
                    data: player,
                });
            })
            .catch(() => {
                res.status(404).json({
                    error: {
                        status: 404,
                        message: 'Player not found.',
                    },
                });
            });
    }

    getById(req, res) {
        this.playersController.getById(req.params.id)
            .then((player) => {
                res.json({
                    data: player,
                });
            })
            .catch(() => {
                res.status(404).json({
                    error: {
                        status: 404,
                        message: 'Player not found.',
                    },
                });
            });
    }

    updateById(req, res) {
        this.playersController.updateById(req.params.id, req.body)
            .then((player) => {
                res.json({
                    data: player,
                });
            })
            .catch(() => {
                res.status(404).json({
                    error: {
                        status: 404,
                        message: 'Player not found.',
                    },
                });
            });
    }
}

module.exports = PlayerRoutes;
