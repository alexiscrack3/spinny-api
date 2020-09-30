const sgMail = require('@sendgrid/mail');
const sinon = require('sinon');
const config = require('config');
const EmailService = require('./../../app/services/email');

const sendgrid = config.get('sendgrid');

describe('EmailService', () => {
    beforeEach(() => {
        process.env = {
            SG_API_KEY: 'SG.ZcjaeqzzEfxab',
        };
        sinon.restore();
    });
    afterEach(() => {
        delete process.env.SG_API_KEY;
    });

    it('should set api key', () => {
        const stub = sinon.stub(sgMail, 'setApiKey');
        // eslint-disable-next-line no-unused-vars
        const testObject = new EmailService(sgMail);

        expect(stub.calledWith(process.env.SG_API_KEY)).toBeTruthy();
    });

    describe('sendWelcomeEmail', () => {
        it('should invoke send on sgMail', () => {
            const to = 'to@mail.com';
            const stub = sinon.stub(sgMail, 'send');
            const testObject = new EmailService(sgMail);
            const data = {
                player: {
                    firstName: 'test',
                },
            };
            const msg = {
                from: sendgrid.sender,
                templateId: sendgrid.templateId,
                personalizations: [{
                    to,
                    dynamic_template_data: data,
                }],
            };

            testObject.sendWelcomeEmail(to, data, sendgrid.templateId);

            expect(stub.calledWith(msg)).toBeTruthy();
        });
    });

    describe('sendEmail', () => {
        it('should invoke send on sgMail', () => {
            const to = 'to@mail.com';
            const stub = sinon.stub(sgMail, 'send');
            const testObject = new EmailService(sgMail);
            const data = {
                player: {
                    firstName: 'test',
                },
            };
            const msg = {
                from: sendgrid.sender,
                templateId: sendgrid.templateId,
                personalizations: [{
                    to,
                    dynamic_template_data: data,
                }],
            };

            testObject.sendEmail(to, data, sendgrid.templateId);

            expect(stub.calledWith(msg)).toBeTruthy();
        });
    });
});
