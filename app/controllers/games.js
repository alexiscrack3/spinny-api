const APIError = require('../models/api-error');
const APIResponse = require('../models/api-response');
const logger = require('../helpers/logger');

class GameController {
    constructor(gamesRepository) {
        this.gamesRepository = gamesRepository;
    }

    create(req, res) {
        this.gamesRepository.create(req.body)
            .then((game) => {
                res.status(201).json(new APIResponse(game));
            })
            .catch((err) => {
                logger.error(err);
                res.status(500).json(new APIResponse(null, [
                    new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                ]));
            });
    }

    deleteById(req, res) {
        this.gamesRepository.deleteById(req.params.id)
            .then(() => {
                res
                    .status(204)
                    .end();
            })
            .catch((err) => {
                logger.error(err);
                res.status(500).json(new APIResponse(null, [
                    new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                ]));
            });
    }

    getAll(req, res) {
        this.gamesRepository.getAll()
            .then((games) => {
                res.json(new APIResponse(games));
            })
            .catch((err) => {
                logger.error(err);
                res.status(500).json(new APIResponse(null, [
                    new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                ]));
            });
    }
}

module.exports = GameController;
