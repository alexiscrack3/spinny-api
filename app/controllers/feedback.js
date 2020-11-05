const APIError = require('../models/api-error');
const APIResponse = require('../models/api-response');
const logger = require('../helpers/logger');

class FeedbackController {
    constructor(feedbackRepository) {
        this.feedbackRepository = feedbackRepository;
    }

    send(req, res) {
        this.feedbackRepository.send(req.body)
            .then(() => {
                res.status(204).json(new APIResponse());
            })
            .catch((err) => {
                logger.error(err);
                res.status(500).json(new APIResponse(null, [
                    new APIError('INTERNAL_ERROR', 'Something went wrong.'),
                ]));
            });
    }
}

module.exports = FeedbackController;
