const request = require('supertest');
const app = require('../../app');

describe('GET /players', () => {
    test('responds with json containing a list of players', (done) => {
        request(app)
            .get('/players')
            .set('Accept', 'application/json')
            .expect('Content-Type', /json/)
            .expect(200, done);
    });
});
