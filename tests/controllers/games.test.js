const mongoose = require('mongoose');
const sinon = require('sinon');

const GamesController = require('../../app/controllers/games');
const Game = require('../../app/models/game');

describe('games controller', () => {
    beforeEach(() => {
        sinon.restore();
    });

    describe('deleteById', () => {
        it('should delete game', (done) => {
            const id = new mongoose.Types.ObjectId();
            const body = {
                _id: id,
                winner: new mongoose.Types.ObjectId(),
                loser: new mongoose.Types.ObjectId(),
            };
            const gameMock = sinon.mock(Game);
            gameMock
                .expects('findOneAndRemove')
                .withArgs({ _id: id.toHexString() })
                .yields(null, body);

            const gamesController = new GamesController(Game);
            gamesController.deleteById(id.toHexString()).then((game) => {
                gameMock.verify();
                gameMock.restore();
                expect(body).toBe(game);
                done();
            }).catch((err) => {
                done(err);
            });
        });

        it('should return error', () => {
            const id = new mongoose.Types.ObjectId();
            const error = new Error();
            const gameMock = sinon.mock(Game);
            gameMock
                .expects('findOneAndRemove')
                .withArgs({ _id: id.toHexString() })
                .yields(error, null);

            const gamesController = new GamesController(Game);
            return gamesController.deleteById(id.toHexString()).catch((err) => {
                gameMock.verify();
                gameMock.restore();
                expect(err).toBe(error);
            });
        });

        it('should return error when id does not exist', () => {
            const id = new mongoose.Types.ObjectId();
            const gameMock = sinon.mock(Game);
            gameMock
                .expects('findOneAndRemove')
                .withArgs({ _id: id.toHexString() })
                .yields(null, null);

            const gamesController = new GamesController(Game);
            return gamesController.deleteById(id.toHexString()).catch((err) => {
                gameMock.verify();
                gameMock.restore();
                expect(err).toEqual(new Error('Game id does not exist'));
            });
        });
    });

    describe('create', () => {
        it('should create game when winner and loser are not the same', (done) => {
            const body = {
                winner: new mongoose.Types.ObjectId(),
                loser: new mongoose.Types.ObjectId(),
            };
            const gameMock = sinon.mock(Game);
            gameMock
                .expects('create')
                .resolves(body);

            const gamesController = new GamesController(Game);
            gamesController.create(body).then((game) => {
                gameMock.verify();
                gameMock.restore();
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

            const gamesController = new GamesController(Game);
            return gamesController.create(body).catch((err) => {
                expect(err).toEqual(new Error('Winner and loser cannot be same player'));
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
            const gameStub = sinon.stub(Game, 'find');
            gameStub.returns({
                find: sinon.stub().returnsThis(),
                populate: sinon.stub().returnsThis(),
                exec: sinon.stub().resolves(results),
            });

            const gamesController = new GamesController(Game);
            gamesController.getAll().then((games) => {
                gameStub.restore();
                expect(results).toBe(games);
                done();
            }).catch((err) => {
                done(err);
            });
        });
    });
});
