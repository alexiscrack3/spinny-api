const APIError = require('../models/api-error');
const APIResponse = require('../models/api-response');
const logger = require('../helpers/logger');

class PlayerController {
    constructor(playersRepository) {
        this.playersRepository = playersRepository;
    }

    getAll(req, res) {
        const { skip = 0, limit = 0 } = req.query;
        this.playersRepository.getAll(limit, skip)
            .then((players) => {
                res.json(new APIResponse(players));
            })
            .catch((err) => {
                logger.error(err);
                res.status(500).json(new APIResponse(null, [
                    new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                ]));
            });
    }

    getProfile(req, res) {
        this.playersRepository.getById(req.user.id)
            .then((player) => {
                if (player) {
                    res.json(new APIResponse(player));
                } else {
                    res.status(404).json(new APIResponse(null, [
                        new APIError('INVALID_PARAMETER', 'Player not found.'),
                    ]));
                }
            })
            .catch((err) => {
                logger.error(err);
                res.status(500).json(new APIResponse(null, [
                    new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                ]));
            });
    }

    getById(req, res) {
        this.playersRepository.getById(req.params.id)
            .then((player) => {
                if (player) {
                    res.json(new APIResponse(player));
                } else {
                    res.status(404).json(new APIResponse(null, [
                        new APIError('INVALID_PARAMETER', 'Player not found.'),
                    ]));
                }
            })
            .catch((err) => {
                logger.error(err);
                res.status(500).json(new APIResponse(null, [
                    new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                ]));
            });
    }

    updateById(req, res) {
        this.playersRepository.updateById(req.params.id, req.body)
            .then((player) => {
                if (player) {
                    res.json(new APIResponse(player));
                } else {
                    res.status(404).json(new APIResponse(null, [
                        new APIError('INVALID_PARAMETER', 'Player not found.'),
                    ]));
                }
            })
            .catch((err) => {
                logger.error(err);
                res.status(500).json(new APIResponse(null, [
                    new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                ]));
            });
    }
}

module.exports = PlayerController;
