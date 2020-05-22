const GamesController = require('../controllers/games');

exports.create = (req, res) => {
    GamesController.create(req.body)
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
};

exports.deleteById = (req, res) => {
    GamesController.deleteById(req.params.id)
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

exports.getAll = (req, res) => {
    GamesController.getAll()
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
};
