const APIError = require('../models/api-error');
const APIResponse = require('../models/api-response');

class FeedbackController {
    constructor(feedbackRepository) {
        this.feedbackRepository = feedbackRepository;
    }

    send(req, res) {
        this.feedbackRepository.send(req.body)
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

module.exports = FeedbackController;
