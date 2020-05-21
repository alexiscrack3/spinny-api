const ClubController = require('../controllers/club');

exports.create = (req, res) => {
    ClubController.create(req.body)
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
};

exports.getAll = (req, res) => {
    ClubController.getAll()
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
};

exports.addPlayer = (req, res) => {
    ClubController.addPlayer(req.params.id, req.body.playerId)
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
};
