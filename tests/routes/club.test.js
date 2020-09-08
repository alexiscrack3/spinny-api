const mongoose = require('mongoose');
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
            .expect(201)
            .then((res) => {
                const { data, errors } = res.body;
                expect(data.name).toBe(body.name);
                expect(errors.length).toBe(0);
                done();
            })
            .catch((err) => {
                done(err);
            });
    });

    it('responds with json containing an error', (done) => {
        const body = {
            name: 'club',
        };
        mockingoose(Club).toReturn(new Error(), 'save');

        request(app)
            .post('/clubs')
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
                const { data, errors } = res.body;
                const obj = data[0];
                expect(data.length).toBe(1);
                expect(obj.name).toBe(body.name);
                expect(errors.length).toBe(0);
                done();
            })
            .catch((err) => {
                done(err);
            });
    });

    it('responds with json containing an error', (done) => {
        mockingoose(Club).toReturn(new Error(), 'find');

        request(app)
            .get('/clubs')
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

describe('GET /clubs/:id', () => {
    it('responds with json containing a club', (done) => {
        const body = {
            name: 'club',
        };
        const club = Club(body);
        mockingoose(Club).toReturn(club, 'findOne');

        request(app)
            .get(`/clubs/${club.id}`)
            .expect('Content-Type', /json/)
            .expect(200)
            .then((res) => {
                const { data, errors } = res.body;
                expect(data.name).toBe(body.name);
                expect(errors.length).toBe(0);
                done();
            });
    });

    it('responds with json containing an error when club is not found', (done) => {
        const id = new mongoose.Types.ObjectId().toHexString();
        mockingoose(Club).toReturn(null, 'findOne');

        request(app)
            .get(`/clubs/${id}`)
            .expect('Content-Type', /json/)
            .expect(404)
            .then((res) => {
                const { data, errors } = res.body;
                const err = errors[0];
                expect(data).toBeNull();
                expect(err.code).toBe('INVALID_PARAMETER');
                expect(err.message).toBe('Club not found.');
                done();
            });
    });

    it('responds with json containing an error', (done) => {
        const id = new mongoose.Types.ObjectId().toHexString();
        mockingoose(Club).toReturn(new Error(), 'findOne');

        request(app)
            .get(`/clubs/${id}`)
            .expect('Content-Type', /json/)
            .expect(500)
            .then((res) => {
                const { data, errors } = res.body;
                const err = errors[0];
                expect(data).toBeNull();
                expect(err.code).toBe('INTERNAL_ERROR');
                expect(err.message).toBe('Something went wrong.');
                done();
            });
    });
});

describe('GET /clubs?playerId=:id', () => {
    it('responds with json containing a list of clubs that a player belongs to', (done) => {
        const id = new mongoose.Types.ObjectId().toHexString();
        const body = {
            name: 'club',
        };
        const club = Club(body);
        mockingoose(Club).toReturn([club], 'find');

        request(app)
            .get('/clubs')
            .query({ playerId: id })
            .expect('Content-Type', /json/)
            .expect(200)
            .then((res) => {
                const { data, errors } = res.body;
                const obj = data[0];
                expect(data.length).toBe(1);
                expect(obj.name).toBe(body.name);
                expect(errors.length).toBe(0);
                done();
            })
            .catch((err) => {
                done(err);
            });
    });
});

describe('PUT /clubs/:id/players', () => {
    it('responds with no content', (done) => {
        const id = new mongoose.Types.ObjectId().toHexString();
        mockingoose(Club).toReturn({ nModified: 1 }, 'update');

        request(app)
            .put(`/clubs/${id}/players`)
            .expect(204, done);
    });

    it('responds with json containing an error', (done) => {
        const id = new mongoose.Types.ObjectId().toHexString();
        mockingoose(Club).toReturn(new Error(), 'update');

        request(app)
            .put(`/clubs/${id}/players`)
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
