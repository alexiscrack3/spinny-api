const APIError = require('../models/api-error');
const APIResponse = require('../models/api-response');

class ClubsController {
    constructor(clubsRepository) {
        this.clubsRepository = clubsRepository;
    }

    create(req, res) {
        this.clubsRepository.create(req.body)
            .then((club) => {
                res.status(201).json(new APIResponse(club));
            })
            .catch(() => {
                res.status(500).json(new APIResponse(null, [
                    new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                ]));
            });
    }

    getById(req, res) {
        this.clubsRepository.getById(req.params.id)
            .then((club) => {
                if (club) {
                    res.json(new APIResponse(club));
                } else {
                    res.status(404).json(new APIResponse(null, [
                        new APIError('INVALID_PARAMETER', 'Club not found.'),
                    ]));
                }
            })
            .catch(() => {
                res.status(500).json(new APIResponse(null, [
                    new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                ]));
            });
    }

    getAll(req, res) {
        let documentQuery = null;
        if (req.query && req.query.playerId) {
            documentQuery = this.clubsRepository.getAllByPlayerId(req.query.playerId);
        } else {
            documentQuery = this.clubsRepository.getAll();
        }
        documentQuery
            .then((clubs) => {
                res.json(new APIResponse(clubs));
            })
            .catch(() => {
                res.status(500).json(new APIResponse(null, [
                    new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                ]));
            });
    }

    addPlayer(req, res) {
        this.clubsRepository.addPlayer(req.params.id, req.body.playerId)
            .then(() => {
                res
                    .status(204)
                    .end();
            })
            .catch(() => {
                res.status(500).json(new APIResponse(null, [
                    new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                ]));
            });
    }
}

module.exports = ClubsController;
