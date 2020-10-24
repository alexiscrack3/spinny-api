const mongoose = require('mongoose');
const sinon = require('sinon');
const request = require('supertest');
const app = require('../../app');
const EmailService = require('../../app/services/email');

describe('POST /feedback', () => {
    afterEach(() => {
        sinon.restore();
    });

    it('responds with no content', (done) => {
        const body = {
            player: {
                id: new mongoose.Types.ObjectId().toHexString(),
                first_name: 'Foo',
                last_name: 'Bar',
            },
            message: 'message',
        };

        sinon.stub(EmailService.prototype, 'sendFeedback').resolves();

        request(app)
            .post('/feedback')
            .send(body)
            .expect(204)
            .then((res) => {
                const { data, errors } = res.body;
                expect(data).toBeUndefined();
                expect(errors).toBeUndefined();
                done();
            })
            .catch((err) => {
                done(err);
            });
    });

    it('responds with json containing an internal error', (done) => {
        const body = {
            player: {
                id: new mongoose.Types.ObjectId().toHexString(),
                first_name: 'Foo',
                last_name: 'Bar',
            },
            message: 'message',
        };

        sinon.stub(EmailService.prototype, 'sendFeedback').rejects();

        request(app)
            .post('/feedback')
            .send(body)
            .expect('Content-Type', /json/)
            .expect(500)
            .then((res) => {
                const { data, errors } = res.body;
                const err = errors[0];
                expect(data).toBeNull();
                expect(err.code).toBe('INTERNAL_ERROR');
                expect(err.message).toBe('Something went wrong.');
                done();
            })
            .catch((err) => {
                done(err);
            });
    });
});
