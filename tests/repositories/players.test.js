const mongoose = require('mongoose');
const sinon = require('sinon');
const Player = require('../../app/models/player');
const PlayersRepository = require('../../app/repositories/players');

describe('PlayersRepository', () => {
    beforeEach(() => {
        sinon.restore();
    });

    describe('create', () => {
        it('should invoke create on model', () => {
            const body = {
                email: 'user@spinny.io',
            };
            const stub = sinon.stub(Player, 'create');
            const testObject = new PlayersRepository(Player);

            testObject.create(body);

            expect(stub.calledWith(body)).toBeTruthy();
        });
    });

    describe('updateById', () => {
        it('should invoke findOneAndUpdate on model', () => {
            const id = new mongoose.Types.ObjectId().toHexString();
            const body = {
                email: 'user@spinny.io',
            };
            const stub = sinon.stub(Player, 'findByIdAndUpdate');
            const testObject = new PlayersRepository(Player);

            testObject.updateById(id, body);

            expect(stub.calledWith(id, body, { new: true })).toBeTruthy();
        });
    });

    describe('getById', () => {
        it('should invoke findById on model', () => {
            const id = new mongoose.Types.ObjectId().toHexString();
            const spy = sinon.spy(Player, 'findById');
            const testObject = new PlayersRepository(Player);

            testObject.getById(id);

            expect(spy.calledWith(id)).toBeTruthy();
        });
    });

    describe('getByEmail', () => {
        it('should invoke findOne with email on model', () => {
            const email = 'user@spinny.io';
            const spy = sinon.spy(Player, 'findOne');
            const testObject = new PlayersRepository(Player);

            testObject.getByEmail(email);

            expect(spy.calledWith({ email })).toBeTruthy();
        });
    });

    describe('getAll', () => {
        it('should invoke find on model', () => {
            const testObject = new PlayersRepository(Player);
            const spy = sinon.spy(Player, 'find');

            testObject.getAll();

            expect(spy.calledOnce).toBeTruthy();
        });
    });
});
