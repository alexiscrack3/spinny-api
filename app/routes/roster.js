const RosterController = require('../controllers/roster');

exports.getAll = (req, res) => {
    RosterController.getAll()
        .then((roster) => {
            res.json({
                data: roster,
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
