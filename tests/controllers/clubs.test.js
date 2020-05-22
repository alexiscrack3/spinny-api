const mongoose = require('mongoose');
const sinon = require('sinon');
const ClubsController = require('../../app/controllers/clubs');
const Club = require('../../app/models/club');

describe('clubs controller', () => {
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

            const clubsController = new ClubsController(Club);
            clubsController.create(body).then((club) => {
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

            const clubsController = new ClubsController(Club);
            clubsController.create(body).then(() => {
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

            const clubsController = new ClubsController(Club);
            clubsController.getAll().then((clubs) => {
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

            const clubsController = new ClubsController(Club);
            clubsController.getAll().then(() => {
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

            const clubsController = new ClubsController(Club);
            clubsController.addPlayer(id, playerId).then(() => {
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
            const clubsController = new ClubsController(Club);
            return clubsController.addPlayer(id, playerId).catch((err) => {
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
            const clubsController = new ClubsController(Club);
            return clubsController.addPlayer(id, playerId).catch((err) => {
                expect(err).toEqual(new Error('Player was not added to the club'));
            });
        });
    });
});
