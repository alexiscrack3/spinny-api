const ClubsController = require('../controllers/clubs');
const Club = require('../models/club');

exports.create = (req, res) => {
    const clubsController = new ClubsController(Club);
    clubsController.create(req.body)
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
    const clubsController = new ClubsController(Club);
    let documentQuery = null;
    if (req.query && req.query.playerId) {
        documentQuery = clubsController.getByPlayerId(req.query.playerId);
    } else {
        documentQuery = clubsController.getAll();
    }
    documentQuery
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
    const clubsController = new ClubsController(Club);
    clubsController.addPlayer(req.params.id, req.body.playerId)
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

// exports.getByPlayerId = (req, res) => {
//     const clubsController = new ClubsController();
//     clubsController.getByPlayerId(req.params.id)
//         .then((clubs) => {
//             res.json({
//                 data: clubs,
//             });
//         })
//         .catch(() => {
//             res.status(500).json({
//                 error: {
//                     status: 500,
//                     message: 'Request could not be completed.',
//                 },
//             });
//         });
// };
