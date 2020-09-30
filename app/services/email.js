// const sgMail = require('@sendgrid/mail');
const config = require('config');

const sendgrid = config.get('sendgrid');

class EmailService {
    constructor(sgMail, from = sendgrid.sender) {
        this.from = from;
        this.sgMail = sgMail;
        this.sgMail.setApiKey(process.env.SG_API_KEY);
    }

    sendWelcomeEmail(to, data) {
        return this.sendEmail(to, data, sendgrid.templateId);
    }

    sendEmail(to, data, templateId) {
        const msg = {
            from: this.from,
            templateId,
            personalizations: [{
                to,
                dynamic_template_data: data,
            }],
        };
        return this.sgMail.send(msg);
    }
}

module.exports = EmailService;
