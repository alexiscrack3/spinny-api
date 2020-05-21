const mongoose = require('mongoose');
const mockingoose = require('mockingoose').default;
const MockModel = require('jest-mongoose-mock');

describe('club controller', () => {
    beforeEach(() => {
        jest.clearAllMocks();
        mockingoose.resetAll();
    });

    describe('addPlayer', () => {
        let ClubController;
        let Club;

        jest.isolateModules(() => {
            ClubController = require('../../app/controllers/club');
            Club = require('../../app/models/club');
        });

        it('should add player to club', (done) => {
            const id = new mongoose.Types.ObjectId().toHexString();
            const playerId = new mongoose.Types.ObjectId().toHexString();
            mockingoose(Club).toReturn({ nModified: 1 }, 'update');
            ClubController.addPlayer(id, playerId).then(() => {
                done();
            }).catch((err) => {
                done(err);
            });
        });

        it('should return error', () => {
            const id = new mongoose.Types.ObjectId().toHexString();
            const playerId = new mongoose.Types.ObjectId().toHexString();
            const error = new Error();
            mockingoose(Club).toReturn(error, 'update');
            return ClubController.addPlayer(id, playerId).catch((err) => {
                expect(err).toBe(error);
            });
        });

        it('should return error when player was not added to the club', () => {
            const id = new mongoose.Types.ObjectId().toHexString();
            const playerId = new mongoose.Types.ObjectId().toHexString();
            mockingoose(Club).toReturn({ nModified: 0 }, 'update');
            return ClubController.addPlayer(id, playerId).catch((err) => {
                expect(err).toEqual(new Error('Player was not added to the club'));
            });
        });
    });

    describe('create', () => {
        let ClubController;
        let Club;
        jest.isolateModules(() => {
            ClubController = require('../../app/controllers/club');
            Club = require('../../app/models/club');
        });

        jest.mock('../../app/models/club', () => new MockModel());

        it('should create club', (done) => {
            const body = {
                name: 'club',
            };
            ClubController.create(body).then(() => {
                expect(Club.create.mock.calls.length).toBe(1);
                expect(Club.create.mock.calls[0][0]).toBe(body);
                done();
            }).catch((err) => {
                done(err);
            });
        });
    });

    describe('getAll', () => {
        let ClubController;
        let Club;
        jest.isolateModules(() => {
            ClubController = require('../../app/controllers/club');
            Club = require('../../app/models/club');
        });

        jest.mock('../../app/models/club', () => new MockModel());

        it('should get players', (done) => {
            ClubController.getAll().then(() => {
                expect(Club.find.mock.calls.length).toBe(1);
                done();
            }).catch((err) => {
                done(err);
            });
        });
    });
});
