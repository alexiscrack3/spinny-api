const mockingoose = require('mockingoose').default;
const request = require('supertest');
const app = require('../../app');
const Club = require('../../app/models/club');

describe('POST /clubs', () => {
    it('responds with json containing a club', (done) => {
        const body = {
            name: 'club',
        };
        const club = Club(body);
        mockingoose(Club).toReturn(club, 'save');

        request(app)
            .post('/clubs')
            .send(body)
            .expect('Content-Type', /json/)
            .expect(200)
            .then((res) => {
                const { data } = res.body;
                expect(data.name).toBe(body.name);
                done();
            })
            .catch((err) => {
                done(err);
            });
    });

    it('responds with json containing an error', (done) => {
        const statusCode = 500;
        const body = {
            name: 'club',
        };
        mockingoose(Club).toReturn(new Error(), 'save');

        request(app)
            .post('/clubs')
            .send(body)
            .expect('Content-Type', /json/)
            .expect(statusCode)
            .then((res) => {
                const err = res.body.error;
                expect(err.status).toBe(statusCode);
                expect(err.message).toBeDefined();
                done();
            })
            .catch((err) => {
                done(err);
            });
    });
});

describe('GET /clubs', () => {
    it('responds with json containing a list of clubs', (done) => {
        const body = {
            name: 'club',
        };
        const club = Club(body);
        mockingoose(Club).toReturn([club], 'find');

        request(app)
            .get('/clubs')
            .expect('Content-Type', /json/)
            .expect(200)
            .then((res) => {
                const { data } = res.body;
                expect(data.length).toBe(1);

                const obj = data[0];
                expect(obj.email).toBe(body.email);
                expect(obj.password).toBe(body.password);
                done();
            });
    });

    it('responds with json containing an error', (done) => {
        const statusCode = 500;
        mockingoose(Club).toReturn(new Error(), 'find');

        request(app)
            .get('/clubs')
            .expect('Content-Type', /json/)
            .expect(statusCode)
            .then((res) => {
                const err = res.body.error;
                expect(err.status).toBe(statusCode);
                expect(err.message).toBeDefined();
                done();
            });
    });
});
