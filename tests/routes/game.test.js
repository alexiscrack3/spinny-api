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
            });
    });
});

describe('POST /games', () => {
    it('responds with json containing a game', (done) => {
        const body = {
            winner: new mongoose.Types.ObjectId().toString(),
            loser: new mongoose.Types.ObjectId().toString(),
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
                expect(data.winner.toString()).toBe(body.winner.toString());
                expect(data.loser.toString()).toBe(body.loser.toString());
                done();
            });
    });

    it('responds with json containing an error', (done) => {
        const statusCode = 500;
        const body = {
            winner: new mongoose.Types.ObjectId().toString(),
            loser: new mongoose.Types.ObjectId().toString(),
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
            });
    });
});
