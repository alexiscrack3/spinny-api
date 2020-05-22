class GameRoutes {
    constructor(gamesController) {
        this.gamesController = gamesController;
    }

    create(req, res) {
        this.gamesController.create(req.body)
            .then((game) => {
                res.json({
                    data: game,
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

    deleteById(req, res) {
        this.gamesController.deleteById(req.params.id)
            .then(() => {
                res
                    .status(204)
                    .end();
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

    getAll(req, res) {
        this.gamesController.getAll()
            .then((games) => {
                res.json({
                    data: games,
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
}

module.exports = GameRoutes;
