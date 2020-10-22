const APIError = require('../models/api-error');
const APIResponse = require('../models/api-response');

class FeedbackRoutes {
    constructor(feedbackController) {
        this.feedbackController = feedbackController;
    }

    send(req, res) {
        this.feedbackController.send(req.body)
            .then(() => {
                res.status(204).json(new APIResponse());
            })
            .catch(() => {
                res.status(500).json(new APIResponse(null, [
                    new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                ]));
            });
    }
}

module.exports = FeedbackRoutes;
