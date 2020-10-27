const express = require('express');
const sgMail = require('@sendgrid/mail');
const FeedbackController = require('../app/controllers/feedback');
const FeedbackRoutes = require('../app/routes/feedback');
const EmailService = require('../app/services/email');

const emailService = new EmailService(sgMail);
const feedbackController = new FeedbackController(emailService);
const feedbackRoutes = new FeedbackRoutes(feedbackController);
const feedbackRouter = express.Router();

feedbackRouter.post('/', (req, res) => feedbackRoutes.send(req, res));

module.exports = feedbackRouter;
