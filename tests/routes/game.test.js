const mongoose = require('mongoose');
const mockingoose = require('mockingoose').default;
const request = require('supertest');
const app = require('../../app');
const Game = require('../../app/models/game');

describe('GET /games', () => {
    it('responds with json containing a list of games', (done) => {
        const body = {
            winner: new mongoose.Types.ObjectId(),
            loser: new mongoose.Types.ObjectId(),
        };
        const game = Game(body);
        mockingoose(Game).toReturn([game], 'find');

        request(app)
            .get('/games')
            .expect('Content-Type', /json/)
            .expect(200)
            .then((res) => {
                const { data } = res.body;
                expect(data.length).toBe(1);

                const obj = data[0];
                expect(obj.winner.toString()).toBe(body.winner.toString());
                expect(obj.loser.toString()).toBe(body.loser.toString());
                done();
            })
            .catch((err) => {
                done(err);
            });
    });

    it('responds with json containing an error', (done) => {
        const statusCode = 500;
        mockingoose(Game).toReturn(new Error(), 'find');

        request(app)
            .get('/games')
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

describe('POST /games', () => {
    it('responds with json containing a game', (done) => {
        const body = {
            winner: new mongoose.Types.ObjectId(),
            loser: new mongoose.Types.ObjectId(),
        };
        const game = Game(body);
        mockingoose(Game).toReturn(game, 'save');

        request(app)
            .post('/games')
            .send(body)
            .expect('Content-Type', /json/)
            .expect(200)
            .then((res) => {
                const { data } = res.body;
                expect(data.winner).toBe(body.winner.toHexString());
                expect(data.loser).toBe(body.loser.toHexString());
                done();
            })
            .catch((err) => {
                done(err);
            });
    });

    it('responds with json containing an error', (done) => {
        const statusCode = 500;
        const body = {
            winner: new mongoose.Types.ObjectId(),
            loser: new mongoose.Types.ObjectId(),
        };
        mockingoose(Game).toReturn(new Error(), 'save');

        request(app)
            .post('/games')
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

describe('DELETE /games/:id', () => {
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
            .delete(`/games/${id.toHexString()}`)
            .expect(204, done);
    });

    it('responds with json containing an error', (done) => {
        const statusCode = 500;
        const id = new mongoose.Types.ObjectId().toHexString();
        mockingoose(Game).toReturn(new Error(), 'findOneAndRemove');

        request(app)
            .delete(`/games/${id}`)
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
