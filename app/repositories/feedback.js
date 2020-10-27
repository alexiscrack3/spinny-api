const config = require('config');

const sendgrid = config.get('sendgrid');

class FeedbackRepository {
    constructor(emailService) {
        this.emailService = emailService;
    }

    send(feedback) {
        return this.emailService.sendFeedback(sendgrid.support, feedback);
    }
}

module.exports = FeedbackRepository;
