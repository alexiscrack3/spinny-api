const mongoose = require('mongoose');
const sinon = require('sinon');
const Club = require('../../app/models/club');
const ClubsRepository = require('../../app/repositories/clubs');

describe('ClubsRepository', () => {
    beforeEach(() => {
        sinon.restore();
    });

    describe('create', () => {
        it('should invoke create on model', () => {
            const body = {
                name: 'club',
            };
            const stub = sinon.stub(Club, 'create');
            const testObject = new ClubsRepository(Club);

            testObject.create(body);

            expect(stub.calledWith(body)).toBeTruthy();
        });
    });

    describe('getById', () => {
        it('should invoke findById on model', () => {
            const id = new mongoose.Types.ObjectId().toHexString();
            const clubStub = sinon.stub(Club, 'findById');
            const populateStub = sinon.stub();
            clubStub.returns({
                find: sinon.stub().returnsThis(),
                populate: populateStub.returnsThis(),
            });
            const testObject = new ClubsRepository(Club);

            testObject.getById(id);

            expect(clubStub.withArgs(id).calledOnce).toBeTruthy();
            expect(populateStub.calledWith('members')).toBeTruthy();
            expect(populateStub.calledAfter(clubStub)).toBeTruthy();
        });
    });

    describe('getAll', () => {
        it('should invoke find on model', () => {
            const spy = sinon.spy(Club, 'find');
            const testObject = new ClubsRepository(Club);

            testObject.getAll();

            expect(spy.calledOnce).toBeTruthy();
        });
    });

    describe('getAllByPlayerId', () => {
        it('should invoke find with playerId on model', () => {
            const playerId = new mongoose.Types.ObjectId().toHexString();
            const clubStub = sinon.stub(Club, 'find');
            const populateStub = sinon.stub();
            const execStub = sinon.stub();
            clubStub.returns({
                find: sinon.stub().returnsThis(),
                populate: populateStub.returnsThis(),
                exec: execStub,
            });
            const testObject = new ClubsRepository(Club);

            testObject.getAllByPlayerId(playerId);

            expect(clubStub.calledWith({ members: { $in: [playerId] } })).toBeTruthy();
            expect(populateStub.calledWith({ path: 'members', select: 'email' })).toBeTruthy();
            expect(populateStub.calledAfter(clubStub)).toBeTruthy();
            expect(execStub.calledAfter(populateStub)).toBeTruthy();
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

            const testObject = new ClubsRepository(Club);
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
            const testObject = new ClubsRepository(Club);
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
            const testObject = new ClubsRepository(Club);
            return testObject.addPlayer(id, playerId).catch((err) => {
                expect(err).toEqual(new Error('Player was not added to the club'));
            });
        });
    });
});
