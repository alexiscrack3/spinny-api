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
                const { data } = res.body;
                expect(data.user.id).toBe(player.id);
                expect(data).toHaveProperty('token');
                done();
            });
    });

    it('responds with json containing an error', (done) => {
        const statusCode = 400;
        passport.use(new MockStrategy({
            name: 'local-login',
            passReqToCallback: true,
        }, (req, user, cb) => {
            cb(new Error(), null);
        }));

        request(app)
            .post('/auth/sign_in')
            .expect('Content-Type', /json/)
            .expect(statusCode)
            .then((res) => {
                const err = res.body.error;
                expect(err.status).toBe(statusCode);
                expect(err.message).toBeDefined();
                done();
            });
    });

    it('responds with json containing an error when user is null', (done) => {
        const statusCode = 400;
        passport.use(new MockStrategy({
            name: 'local-login',
            passReqToCallback: true,
        }, (req, user, cb) => {
            cb(null, null);
        }));

        request(app)
            .post('/auth/sign_in')
            .expect('Content-Type', /json/)
            .expect(statusCode)
            .then((res) => {
                const err = res.body.error;
                expect(err.status).toBe(statusCode);
                expect(err.message).toBeDefined();
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
            .expect(statusCode)
            .then((res) => {
                const err = res.body.error;
                expect(err.status).toBe(statusCode);
                expect(err.message).toBeDefined();
                done();
            });
    });
});
