const mongoose = require('mongoose');
const sinon = require('sinon');
const ClubsController = require('../../app/controllers/clubs');
const Club = require('../../app/models/club');

describe('clubs controller', () => {
    beforeEach(() => {
        sinon.restore();
    });

    describe('create', () => {
        it('should invoke create club on model', () => {
            const body = {
                name: 'club',
            };
            const stub = sinon.stub(Club, 'create');
            const testObject = new ClubsController(Club);

            testObject.create(body);

            expect(stub.calledWith(body)).toBeTruthy();
        });
    });

    describe('getAll', () => {
        it('should invoke find on model', () => {
            const spy = sinon.spy(Club, 'find');
            const testObject = new ClubsController(Club);

            testObject.getAll();

            expect(spy.calledOnce).toBeTruthy();
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

            const testObject = new ClubsController(Club);
            testObject.addPlayer(id, playerId).then(() => {
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
            const testObject = new ClubsController(Club);
            return testObject.addPlayer(id, playerId).catch((err) => {
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
            const testObject = new ClubsController(Club);
            return testObject.addPlayer(id, playerId).catch((err) => {
                expect(err).toEqual(new Error('Player was not added to the club'));
            });
        });
    });
});
