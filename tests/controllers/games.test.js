const mongoose = require('mongoose');
const sinon = require('sinon');
const GamesController = require('../../app/controllers/games');
const Game = require('../../app/models/game');

describe('GamesController', () => {
    beforeEach(() => {
        sinon.restore();
    });

    describe('create', () => {
        it('should create game when winner and loser are not the same', (done) => {
            const body = {
                winner: new mongoose.Types.ObjectId(),
                loser: new mongoose.Types.ObjectId(),
            };
            const mock = sinon.mock(Game);
            mock
                .expects('create')
                .resolves(body);

            const testObject = new GamesController(Game);
            testObject.create(body).then((game) => {
                mock.verify();
                mock.restore();
                expect(body).toBe(game);
                done();
            }).catch((err) => {
                done(err);
            });
        });

        it('should not create game when winner and loser are the same', () => {
            const id = new mongoose.Types.ObjectId();
            const body = {
                winner: id,
                loser: id,
            };

            const testObject = new GamesController(Game);
            return testObject.create(body).catch((err) => {
                expect(err).toEqual(new Error('Winner and loser cannot be same player'));
            });
        });
    });

    describe('deleteById', () => {
        it('should delete game', (done) => {
            const id = new mongoose.Types.ObjectId();
            const body = {
                _id: id,
                winner: new mongoose.Types.ObjectId(),
                loser: new mongoose.Types.ObjectId(),
            };
            const mock = sinon.mock(Game);
            mock
                .expects('findOneAndRemove')
                .withArgs({ _id: id.toHexString() })
                .yields(null, body);

            const testObject = new GamesController(Game);
            testObject.deleteById(id.toHexString()).then((game) => {
                mock.verify();
                mock.restore();
                expect(body).toBe(game);
                done();
            }).catch((err) => {
                done(err);
            });
        });

        it('should return error', () => {
            const id = new mongoose.Types.ObjectId();
            const error = new Error();
            const mock = sinon.mock(Game);
            mock
                .expects('findOneAndRemove')
                .withArgs({ _id: id.toHexString() })
                .yields(error, null);

            const testObject = new GamesController(Game);
            return testObject.deleteById(id.toHexString()).catch((err) => {
                mock.verify();
                mock.restore();
                expect(err).toBe(error);
            });
        });

        it('should return error when id does not exist', () => {
            const id = new mongoose.Types.ObjectId();
            const mock = sinon.mock(Game);
            mock
                .expects('findOneAndRemove')
                .withArgs({ _id: id.toHexString() })
                .yields(null, null);

            const testObject = new GamesController(Game);
            return testObject.deleteById(id.toHexString()).catch((err) => {
                mock.verify();
                mock.restore();
                expect(err).toEqual(new Error('Game id does not exist'));
            });
        });
    });

    describe('getAll', () => {
        it('should get list of games', (done) => {
            const body = {
                winner: new mongoose.Types.ObjectId(),
                loser: new mongoose.Types.ObjectId(),
            };
            const results = [body];
            const stub = sinon.stub(Game, 'find');
            stub.returns({
                find: sinon.stub().returnsThis(),
                populate: sinon.stub().returnsThis(),
                exec: sinon.stub().resolves(results),
            });

            const testObject = new GamesController(Game);
            testObject.getAll().then((games) => {
                stub.restore();
                expect(results).toBe(games);
                done();
            }).catch((err) => {
                done(err);
            });
        });
    });
});
