const mongoose = require('mongoose');
const sinon = require('sinon');
const ClubsController = require('../../app/controllers/clubs');
const Club = require('../../app/models/club');

describe('ClubsController', () => {
    beforeEach(() => {
        sinon.restore();
    });

    describe('create', () => {
        it('should invoke create on model', () => {
            const body = {
                name: 'club',
            };
            const stub = sinon.stub(Club, 'create');
            const testObject = new ClubsController(Club);

            testObject.create(body);

            expect(stub.calledWith(body)).toBeTruthy();
        });
    });

    describe('getById', () => {
        it('should invoke findById on model', () => {
            const id = new mongoose.Types.ObjectId().toHexString();
            const spy = sinon.spy(Club, 'findById');
            const testObject = new ClubsController(Club);

            testObject.getById(id);

            expect(spy.withArgs(id).calledOnce).toBeTruthy();
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

    describe('getAllByPlayerId', () => {
        it('should invoke find with playerId on model', () => {
            const playerId = new mongoose.Types.ObjectId().toHexString();
            const stub = sinon.stub(Club, 'find');
            const populateSpy = sinon.stub();
            const execSpy = sinon.stub();
            stub.returns({
                find: sinon.stub().returnsThis(),
                populate: populateSpy.returnsThis(),
                exec: execSpy,
            });
            const testObject = new ClubsController(Club);

            testObject.getAllByPlayerId(playerId);

            expect(stub.calledWith({ members: { $in: [playerId] } })).toBeTruthy();
            expect(populateSpy.calledWith({ path: 'members', select: 'email' })).toBeTruthy();
            expect(populateSpy.calledAfter(stub)).toBeTruthy();
            expect(execSpy.calledAfter(populateSpy)).toBeTruthy();
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
