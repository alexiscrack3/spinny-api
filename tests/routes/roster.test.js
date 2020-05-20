const mongoose = require('mongoose');
const mockingoose = require('mockingoose').default;
const request = require('supertest');
const app = require('../../app');
const Roster = require('../../app/models/roster');

describe('GET /roster', () => {
    it('responds with json containing a roster', (done) => {
        const body = {
            club: new mongoose.Types.ObjectId(),
            player: new mongoose.Types.ObjectId(),
        };
        const roster = Roster(body);
        mockingoose(Roster).toReturn([roster], 'find');

        request(app)
            .get('/roster')
            .expect('Content-Type', /json/)
            .expect(200)
            .then((res) => {
                const { data } = res.body;
                expect(data.length).toBe(1);

                const obj = data[0];
                expect(obj.club.toString()).toBe(body.club.toString());
                expect(obj.player.toString()).toBe(body.player.toString());
                done();
            });
    });

    it('responds with json containing an error', (done) => {
        const statusCode = 500;
        mockingoose(Roster).toReturn(new Error(), 'find');

        request(app)
            .get('/roster')
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
