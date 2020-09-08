const request = require('supertest');
const passport = require('passport');
const MockStrategy = require('passport-mock-strategy');
const app = require('../../app');
const Player = require('../../app/models/player');

describe('POST /auth/sign_in', () => {
    it('responds with json containing an user and token', (done) => {
        const body = {
            email: 'user@spinny.com',
            password: 'password',
        };
        const player = Player(body);

        passport.use(new MockStrategy({
            name: 'local-login',
            user: { id: player.id },
            passReqToCallback: true,
        }, (req, user, cb) => {
            cb(null, user);
        }));

        request(app)
            .post('/auth/sign_in')
            .send(`email=${player.email}&password=${player.password}`) // x-www-form-urlencoded
            .expect('Content-Type', /json/)
            .expect(200)
            .then((res) => {
                const { data, errors } = res.body;
                expect(data.user.id).toBe(player.id);
                expect(data).toHaveProperty('token');
                expect(errors.length).toBe(0);
                done();
            });
    });

    it('responds with json containing an error', (done) => {
        passport.use(new MockStrategy({
            name: 'local-login',
            passReqToCallback: true,
        }, (req, user, cb) => {
            cb(new Error(), null);
        }));

        request(app)
            .post('/auth/sign_in')
            .expect('Content-Type', /json/)
            .expect(400)
            .then((res) => {
                const { data, errors } = res.body;
                const err = errors[0];
                expect(data).toBeNull();
                expect(err.code).toBe('INTERNAL_ERROR');
                expect(err.message).toBe('Bad request.');
                done();
            });
    });

    it('responds with json containing an error when user is null', (done) => {
        passport.use(new MockStrategy({
            name: 'local-login',
            passReqToCallback: true,
        }, (req, user, cb) => {
            cb(null, null);
        }));

        request(app)
            .post('/auth/sign_in')
            .expect('Content-Type', /json/)
            .expect(400)
            .then((res) => {
                const { data, errors } = res.body;
                const err = errors[0];
                expect(data).toBeNull();
                expect(err.code).toBe('INTERNAL_ERROR');
                expect(err.message).toBe('Bad request.');
                done();
            });
    });

    it('responds with json containing an error when login fails', (done) => {
        const body = {
            email: 'user@spinny.com',
            password: 'password',
        };
        const player = Player(body);

        passport.use(new MockStrategy({
            name: 'local-login',
            user: { id: player.id },
            passReqToCallback: true,
        }, (req, user, cb) => {
            req.login = (loggedInUser, options, callback) => callback(new Error());
            cb(null, user);
        }));

        request(app)
            .post('/auth/sign_in')
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

describe('POST /auth/sign_up', () => {
    it('responds with json containing an user and token', (done) => {
        const body = {
            email: 'user@spinny.com',
            password: 'password',
        };
        const player = Player(body);

        passport.use(new MockStrategy({
            name: 'local-signup',
            user: { id: player.id },
            passReqToCallback: true,
        }, (req, user, cb) => {
            cb(null, user);
        }));

        request(app)
            .post('/auth/sign_up')
            .send(body)
            .expect('Content-Type', /json/)
            .expect(200)
            .then((res) => {
                const { data, errors } = res.body;
                expect(data.user.id).toBe(player.id);
                expect(data).toHaveProperty('token');
                expect(errors.length).toBe(0);
                done();
            });
    });

    it('responds with json containing an error', (done) => {
        const statusCode = 400;
        passport.use(new MockStrategy({
            name: 'local-signup',
            passReqToCallback: true,
        }, (req, user, cb) => {
            cb(new Error(), null);
        }));

        request(app)
            .post('/auth/sign_up')
            .expect('Content-Type', /json/)
            .expect(statusCode)
            .then((res) => {
                const { data, errors } = res.body;
                const err = errors[0];
                expect(data).toBeNull();
                expect(err.code).toBe('INTERNAL_ERROR');
                expect(err.message).toBe('Bad request.');
                done();
            });
    });

    it('responds with json containing an error when user is null', (done) => {
        const statusCode = 400;
        passport.use(new MockStrategy({
            name: 'local-signup',
            passReqToCallback: true,
        }, (req, user, cb) => {
            cb(null, null);
        }));

        request(app)
            .post('/auth/sign_up')
            .expect('Content-Type', /json/)
            .expect(statusCode)
            .then((res) => {
                const { data, errors } = res.body;
                const err = errors[0];
                expect(data).toBeNull();
                expect(err.code).toBe('INTERNAL_ERROR');
                expect(err.message).toBe('Bad request.');
                done();
            });
    });

    it('responds with json containing an error when login fails', (done) => {
        const statusCode = 500;
        const body = {
            email: 'user@spinny.com',
            password: 'password',
        };
        const player = Player(body);

        passport.use(new MockStrategy({
            name: 'local-signup',
            user: { id: player.id },
            passReqToCallback: true,
        }, (req, user, cb) => {
            req.login = (loggedInUser, options, callback) => callback(new Error());
            cb(null, user);
        }));

        request(app)
            .post('/auth/sign_up')
            .expect('Content-Type', /json/)
            .expect(statusCode)
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
