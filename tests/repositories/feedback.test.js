const sinon = require('sinon');
const sgMail = require('@sendgrid/mail');
const config = require('config');
const EmailService = require('../../app/services/email');
const FeedbackRepository = require('../../app/repositories/feedback');

const sendgrid = config.get('sendgrid');

describe('FeedbackRepository', () => {
    describe('send', () => {
        it('should invoke sendFeedback on email service', () => {
            const emailService = new EmailService(sgMail);
            const stub = sinon.stub(emailService, 'sendFeedback');
            const testObject = new FeedbackRepository(emailService);
            const feedback = {
                message: '',
            };

            testObject.send(feedback);

            expect(stub.calledWith(sendgrid.support, feedback)).toBeTruthy();
        });
    });
});
