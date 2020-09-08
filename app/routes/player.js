const APIError = require('./../models/api-error');

class PlayerRoutes {
    constructor(playersController) {
        this.playersController = playersController;
    }

    getAll(req, res) {
        this.playersController.getAll()
            .then((players) => {
                res.json({
                    data: players,
                    errors: [],
                });
            })
            .catch(() => {
                res.status(500).json({
                    data: null,
                    errors: [
                        new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                    ],
                });
            });
    }

    getProfile(req, res) {
        this.playersController.getById(req.user.id)
            .then((player) => {
                if (player) {
                    res.json({
                        data: player,
                        errors: [],
                    });
                } else {
                    res.status(404).json({
                        data: null,
                        errors: [
                            new APIError('INVALID_PARAMETER', 'Player not found.'),
                        ],
                    });
                }
            })
            .catch(() => {
                res.status(500).json({
                    data: null,
                    errors: [
                        new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                    ],
                });
            });
    }

    getById(req, res) {
        this.playersController.getById(req.params.id)
            .then((player) => {
                if (player) {
                    res.json({
                        data: player,
                        errors: [],
                    });
                } else {
                    res.status(404).json({
                        data: null,
                        errors: [
                            new APIError('INVALID_PARAMETER', 'Player not found.'),
                        ],
                    });
                }
            })
            .catch(() => {
                res.status(500).json({
                    data: null,
                    errors: [
                        new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                    ],
                });
            });
    }

    updateById(req, res) {
        this.playersController.updateById(req.params.id, req.body)
            .then((player) => {
                if (player) {
                    res.json({
                        data: player,
                        errors: [],
                    });
                } else {
                    res.status(404).json({
                        data: null,
                        errors: [
                            new APIError('INVALID_PARAMETER', 'Player not found.'),
                        ],
                    });
                }
            })
            .catch(() => {
                res.status(500).json({
                    data: null,
                    errors: [
                        new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                    ],
                });
            });
    }
}

module.exports = PlayerRoutes;
