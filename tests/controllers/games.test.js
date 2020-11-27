const mongoose = require('mongoose');
const mockingoose = require('mockingoose').default;
const request = require('supertest');
const app = require('../../app');
const Game = require('../../app/models/game');

describe('GET /api/games', () => {
    it('responds with json containing a list of games', (done) => {
        const body = {
            winner: new mongoose.Types.ObjectId(),
            loser: new mongoose.Types.ObjectId(),
        };
        const game = Game(body);
        mockingoose(Game).toReturn([game], 'find');

        request(app)
            .get('/api/games')
            .expect('Content-Type', /json/)
            .expect(200)
            .then((res) => {
                const { data, errors } = res.body;
                const obj = data[0];
                expect(data.length).toBe(1);
                expect(obj.winner.toString()).toBe(body.winner.toString());
                expect(obj.loser.toString()).toBe(body.loser.toString());
                expect(errors.length).toBe(0);
                done();
            })
            .catch((err) => {
                done(err);
            });
    });

    it('responds with json containing an internal error', (done) => {
        mockingoose(Game).toReturn(new Error(), 'find');

        request(app)
            .get('/api/games')
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

describe('POST /api/games', () => {
    it('responds with json containing a game', (done) => {
        const body = {
            winner: new mongoose.Types.ObjectId(),
            loser: new mongoose.Types.ObjectId(),
        };
        const game = Game(body);
        mockingoose(Game).toReturn(game, 'save');

        request(app)
            .post('/api/games')
            .send(body)
            .expect('Content-Type', /json/)
            .expect(201)
            .then((res) => {
                const { data, errors } = res.body;
                expect(data.winner).toBe(body.winner.toHexString());
                expect(data.loser).toBe(body.loser.toHexString());
                expect(errors.length).toBe(0);
                done();
            })
            .catch((err) => {
                done(err);
            });
    });

    it('responds with json containing an internal error', (done) => {
        const statusCode = 500;
        const body = {
            winner: new mongoose.Types.ObjectId(),
            loser: new mongoose.Types.ObjectId(),
        };
        mockingoose(Game).toReturn(new Error(), 'save');

        request(app)
            .post('/api/games')
            .send(body)
            .expect('Content-Type', /json/)
            .expect(statusCode)
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

describe('DELETE /api/games/:id', () => {
    it('responds with no content', (done) => {
        const id = new mongoose.Types.ObjectId();
        const body = {
            _id: id,
            winner: new mongoose.Types.ObjectId(),
            loser: new mongoose.Types.ObjectId(),
        };
        const game = Game(body);
        mockingoose(Game).toReturn(game, 'findOneAndRemove');

        request(app)
            .delete(`/api/games/${id.toHexString()}`)
            .expect(204, done);
    });

    it('responds with json containing an internal error', (done) => {
        const statusCode = 500;
        const id = new mongoose.Types.ObjectId().toHexString();
        mockingoose(Game).toReturn(new Error(), 'findOneAndRemove');

        request(app)
            .delete(`/api/games/${id}`)
            .expect('Content-Type', /json/)
            .expect(statusCode)
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
