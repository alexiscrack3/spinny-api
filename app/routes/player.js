const PlayerController = require('../controllers/player');

exports.getAll = (req, res) => {
    PlayerController.getAll()
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
    PlayerController.getById(req.user.id)
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
    PlayerController.getById(req.params.id)
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

exports.create = (req, res) => {
    PlayerController.create(req.body)
        .then((player) => {
            res.json({
                data: player,
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
