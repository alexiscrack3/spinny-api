const express = require('express');
const sgMail = require('@sendgrid/mail');
const EmailService = require('../app/services/email');
const FeedbackRepository = require('../app/repositories/feedback');
const FeedbackController = require('../app/controllers/feedback');

const emailService = new EmailService(sgMail);
const feedbackRepository = new FeedbackRepository(emailService);
const feedbackController = new FeedbackController(feedbackRepository);
const feedbackRouter = express.Router();

feedbackRouter.post('/', (req, res) => feedbackController.send(req, res));

module.exports = feedbackRouter;
