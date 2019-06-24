const GameController = require('../controllers/game');

exports.getAll = (req, res) => {
    GameController.getAll()
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

exports.create = (req, res) => {
    GameController.save(req.body)
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
