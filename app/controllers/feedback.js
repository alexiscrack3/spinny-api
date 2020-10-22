class FeedbackController {
    constructor(emailService) {
        this.emailService = emailService;
    }

    send(feedback) {
        return this.emailService.sendFeedback(feedback);
    }
}

module.exports = FeedbackController;
