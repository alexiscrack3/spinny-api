const APIError = require('../models/api-error');
const APIResponse = require('../models/api-response');

class PlayerRoutes {
    constructor(playersController) {
        this.playersController = playersController;
    }

    getAll(req, res) {
        this.playersController.getAll()
            .then((players) => {
                res.json(new APIResponse(players));
            })
            .catch(() => {
                res.status(500).json(new APIResponse(null, [
                    new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                ]));
            });
    }

    getProfile(req, res) {
        this.playersController.getById(req.user.id)
            .then((player) => {
                if (player) {
                    res.json(new APIResponse(player));
                } else {
                    res.status(404).json(new APIResponse(null, [
                        new APIError('INVALID_PARAMETER', 'Player not found.'),
                    ]));
                }
            })
            .catch(() => {
                res.status(500).json(new APIResponse(null, [
                    new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                ]));
            });
    }

    getById(req, res) {
        this.playersController.getById(req.params.id)
            .then((player) => {
                if (player) {
                    res.json(new APIResponse(player));
                } else {
                    res.status(404).json(new APIResponse(null, [
                        new APIError('INVALID_PARAMETER', 'Player not found.'),
                    ]));
                }
            })
            .catch(() => {
                res.status(500).json(new APIResponse(null, [
                    new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                ]));
            });
    }

    updateById(req, res) {
        this.playersController.updateById(req.params.id, req.body)
            .then((player) => {
                if (player) {
                    res.json(new APIResponse(player));
                } else {
                    res.status(404).json(new APIResponse(null, [
                        new APIError('INVALID_PARAMETER', 'Player not found.'),
                    ]));
                }
            })
            .catch(() => {
                res.status(500).json(new APIResponse(null, [
                    new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                ]));
            });
    }
}

module.exports = PlayerRoutes;
