const mongoose = require('mongoose');
const mockingoose = require('mockingoose').default;
const request = require('supertest');
const passport = require('passport');
const MockStrategy = require('passport-mock-strategy');
const app = require('../../app');
const Player = require('../../app/models/player');

describe('GET /players', () => {
    it('responds with json containing a list of players', (done) => {
        const body = {
            email: 'user@spinny.com',
            password: 'password',
        };
        const player = Player(body);
        mockingoose(Player).toReturn([player], 'find');

        request(app)
            .get('/players')
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
        mockingoose(Player).toReturn(new Error(), 'find');

        request(app)
            .get('/players')
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

describe('GET /players/me', () => {
    it('responds with json containing user\'s profile', (done) => {
        const body = {
            email: 'user@spinny.com',
            password: 'password',
        };
        const player = Player(body);
        mockingoose(Player).toReturn(player, 'findOne');

        passport.use(new MockStrategy({
            name: 'jwt',
            user: { id: player.id },
            passReqToCallback: true,
        }, (req, user, cb) => {
            cb(null, user);
        }));

        request(app)
            .get('/players/me')
            .expect('Content-Type', /json/)
            .expect(200)
            .then((res) => {
                const { data } = res.body;
                expect(data.email).toBe(body.email);
                expect(data.password).toBe(body.password);
                done();
            });
    });

    it('responds with json containing an error', (done) => {
        mockingoose(Player).toReturn(new Error(), 'findOne');

        passport.use(new MockStrategy({
            name: 'jwt',
            passReqToCallback: true,
        }, (req, user, cb) => {
            cb(null, user);
        }));

        request(app)
            .get('/players/me')
            .expect('Content-Type', /json/)
            .expect(404)
            .then((res) => {
                const err = res.body.error;
                expect(err.status).toBe(404);
                expect(err).toHaveProperty('message');
                done();
            });
    });
});

describe('GET /players/:id', () => {
    it('responds with json containing a player', (done) => {
        const body = {
            email: 'user@spinny.com',
            password: 'password',
        };
        const player = Player(body);
        mockingoose(Player).toReturn(player, 'findOne');

        request(app)
            .get(`/players/${player.id}`)
            .expect('Content-Type', /json/)
            .expect(200)
            .then((res) => {
                const { data } = res.body;
                expect(data.email).toBe(body.email);
                expect(data.password).toBe(body.password);
                done();
            });
    });

    it('responds with json containing an error', (done) => {
        const id = new mongoose.Types.ObjectId().toHexString();
        const statusCode = 404;
        mockingoose(Player).toReturn(new Error(), 'findOne');

        request(app)
            .get(`/players/${id}`)
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

// describe('POST /players', () => {
//     it('responds with json containing a player', (done) => {
//         const body = {
//             email: 'user@spinny.com',
//             password: 'password',
//         };
//         const player = Player(body);
//         mockingoose(Player).toReturn(player, 'save');

//         request(app)
//             .post('/players')
//             .send(body)
//             .expect('Content-Type', /json/)
//             .expect(200)
//             .then((res) => {
//                 const { data } = res.body;
//                 expect(data.email).toBe(body.email);
//                 expect(data.password).toBeDefined();
//                 done();
//             });
//     });

//     it('responds with json containing an error', (done) => {
//         const statusCode = 500;
//         const body = {
//             email: 'user@spinny.com',
//             password: 'password123',
//         };
//         mockingoose(Player).toReturn(new Error(), 'save');

//         request(app)
//             .post('/players')
//             .send(body)
//             .expect('Content-Type', /json/)
//             .expect(statusCode)
//             .then((res) => {
//                 const err = res.body.error;
//                 expect(err.status).toBe(statusCode);
//                 expect(err.message).toBeDefined();
//                 done();
//             });
//     });
// });
