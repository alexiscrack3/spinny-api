const mongoose = require('mongoose');
const sinon = require('sinon');
const ClubController = require('../../app/controllers/club');
const Club = require('../../app/models/club');

describe('club controller', () => {
    beforeEach(() => {
        sinon.restore();
    });

    describe('create', () => {
        it('should create club', (done) => {
            const body = {
                name: 'club',
            };
            const clubMock = sinon.mock(Club);
            clubMock
                .expects('create')
                .withArgs(body)
                .resolves(body);

            const clubController = new ClubController(Club);
            clubController.create(body).then((club) => {
                clubMock.verify();
                clubMock.restore();
                expect(body).toBe(club);
                done();
            }).catch((err) => {
                done(err);
            });
        });

        it('should return error', (done) => {
            const body = {
                name: 'club',
            };
            const clubMock = sinon.mock(Club);
            clubMock
                .expects('create')
                .withArgs(body)
                .returns(Promise.reject());

            const clubController = new ClubController(Club);
            clubController.create(body).then(() => {
                done();
            }).catch((err) => {
                clubMock.verify();
                clubMock.restore();
                done(err);
            });
        });
    });

    describe('getAll', () => {
        it('should get players', (done) => {
            const body = {
                name: 'club',
            };
            const results = [body];
            const clubMock = sinon.mock(Club);
            clubMock
                .expects('find')
                .resolves(results);

            const clubController = new ClubController(Club);
            clubController.getAll().then((clubs) => {
                clubMock.verify();
                clubMock.restore();
                expect(results).toBe(clubs);
                done();
            }).catch((err) => {
                done(err);
            });
        });

        it('should return error', (done) => {
            const clubMock = sinon.mock(Club);
            clubMock
                .expects('find')
                .returns(Promise.reject());

            const clubController = new ClubController(Club);
            clubController.getAll().then(() => {
                done();
            }).catch((err) => {
                clubMock.verify();
                clubMock.restore();
                done(err);
            });
        });
    });

    describe('addPlayer', () => {
        it('should add player to club', (done) => {
            const id = new mongoose.Types.ObjectId().toHexString();
            const playerId = new mongoose.Types.ObjectId().toHexString();
            const clubMock = sinon.mock(Club);
            clubMock
                .expects('update')
                .withArgs(
                    { _id: id, members: { $nin: playerId } },
                    { $push: { members: playerId } },
                )
                .yields(null, { nModified: 1 });

            const clubController = new ClubController(Club);
            clubController.addPlayer(id, playerId).then(() => {
                clubMock.verify();
                clubMock.restore();
                done();
            }).catch((err) => {
                done(err);
            });
        });

        it('should return error', () => {
            const id = new mongoose.Types.ObjectId().toHexString();
            const playerId = new mongoose.Types.ObjectId().toHexString();
            const error = new Error();
            const clubMock = sinon.mock(Club);
            clubMock
                .expects('update')
                .withArgs(
                    { _id: id, members: { $nin: playerId } },
                    { $push: { members: playerId } },
                )
                .yields(error, null);
            const clubController = new ClubController(Club);
            return clubController.addPlayer(id, playerId).catch((err) => {
                expect(err).toBe(error);
            });
        });

        it('should return error when player was not added to the club', () => {
            const id = new mongoose.Types.ObjectId().toHexString();
            const playerId = new mongoose.Types.ObjectId().toHexString();
            const clubMock = sinon.mock(Club);
            clubMock
                .expects('update')
                .withArgs(
                    { _id: id, members: { $nin: playerId } },
                    { $push: { members: playerId } },
                )
                .yields(null, { nModified: 0 });
            const clubController = new ClubController(Club);
            return clubController.addPlayer(id, playerId).catch((err) => {
                expect(err).toEqual(new Error('Player was not added to the club'));
            });
        });
    });
});
