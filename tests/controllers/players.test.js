const MockModel = require('jest-mongoose-mock');
const PlayerController = require('../../app/controllers/player');
const Player = require('../../app/models/player');

jest.mock('../../app/models/player', () => new MockModel());

describe('players controller', () => {
    beforeEach(() => {
        jest.clearAllMocks();
    });

    it('gets players', (done) => {
        PlayerController.getAll().then(() => {
            expect(Player.find.mock.calls.length).toBe(1);
            done();
        }).catch(() => {
            done();
        });
    });

    it('gets player by id', (done) => {
        const id = 3;
        PlayerController.getById(id).then(() => {
            expect(Player.findById.mock.calls.length).toBe(1);
            expect(Player.findById.mock.calls[0][0]).toBe(3);
            done();
        }).catch(() => {
            done();
        });
    });

    it('gets player by email', (done) => {
        const email = 'user@spinny.com';
        PlayerController.getByEmail(email).then(() => {
            expect(Player.findOne.mock.calls.length).toBe(1);
            expect(Player.findOne.mock.calls[0][0].email).toBe(email);
            done();
        }).catch(() => {
            done();
        });
    });

    it('creates player', (done) => {
        const body = {
            email: 'user@spinny.com',
        };
        PlayerController.create(body).then(() => {
            expect(Player.create.mock.calls.length).toBe(1);
            expect(Player.create.mock.calls[0][0]).toBe(body);
            done();
        }).catch(() => {
            done();
        });
    });
});
