class ClubRoutes {
    constructor(clubsController) {
        this.clubsController = clubsController;
    }

    create(req, res) {
        this.clubsController.create(req.body)
            .then((club) => {
                res.json({
                    data: club,
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

    getAll(req, res) {
        let documentQuery = null;
        if (req.query && req.query.playerId) {
            documentQuery = this.clubsController.getAllByPlayerId(req.query.playerId);
        } else {
            documentQuery = this.clubsController.getAll();
        }
        documentQuery
            .then((clubs) => {
                res.json({
                    data: clubs,
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

    addPlayer(req, res) {
        this.clubsController.addPlayer(req.params.id, req.body.playerId)
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
}

module.exports = ClubRoutes;
