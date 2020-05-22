const ClubController = require('../controllers/club');
const Club = require('../models/club');

exports.create = (req, res) => {
    const clubController = new ClubController(Club);
    clubController.create(req.body)
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
    const clubController = new ClubController(Club);
    let documentQuery = null;
    if (req.query && req.query.playerId) {
        documentQuery = clubController.getByPlayerId(req.query.playerId);
    } else {
        documentQuery = clubController.getAll();
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
    const clubController = new ClubController(Club);
    clubController.addPlayer(req.params.id, req.body.playerId)
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
//     const clubController = new ClubController();
//     clubController.getByPlayerId(req.params.id)
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
