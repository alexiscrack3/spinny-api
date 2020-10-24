const sinon = require('sinon');
const sgMail = require('@sendgrid/mail');
const config = require('config');
const FeedbackController = require('../../app/controllers/feedback');
const EmailService = require('../../app/services/email');

const sendgrid = config.get('sendgrid');

describe('FeedbackController', () => {
    describe('send', () => {
        it('should invoke sendFeedback on email service', () => {
            const emailService = new EmailService(sgMail);
            const stub = sinon.stub(emailService, 'sendFeedback');
            const testObject = new FeedbackController(emailService);
            const feedback = {
                message: '',
            };

            testObject.send(feedback);

            expect(stub.calledWith(sendgrid.support, feedback)).toBeTruthy();
        });
    });
});
