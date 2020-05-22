const PlayersController = require('../controllers/players');

exports.getAll = (req, res) => {
    PlayersController.getAll()
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
};

exports.getProfile = (req, res) => {
    PlayersController.getById(req.user.id)
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
};

exports.getById = (req, res) => {
    PlayersController.getById(req.params.id)
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
};
