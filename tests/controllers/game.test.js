const mongoose = require('mongoose');
const mockingoose = require('mockingoose').default;
const MockModel = require('jest-mongoose-mock');

describe('game controller', () => {
    beforeEach(() => {
        jest.clearAllMocks();
        mockingoose.resetAll();
    });

    describe('deleteById', () => {
        let GameController;
        let Game;
        jest.isolateModules(() => {
            GameController = require('../../app/controllers/game');
            Game = require('../../app/models/game');
        });

        it('should delete game', (done) => {
            const id = new mongoose.Types.ObjectId();
            const body = {
                _id: id,
                winner: new mongoose.Types.ObjectId(),
                loser: new mongoose.Types.ObjectId(),
            };
            const game = Game(body);
            mockingoose(Game).toReturn(game, 'findOneAndRemove');
            GameController.deleteById(id.toHexString()).then((obj) => {
                expect(obj._id.toHexString()).toBe(id.toHexString());
                expect(obj.winner.toHexString()).toBe(game.winner.toHexString());
                expect(obj.loser.toString()).toBe(game.loser.toHexString());
                done();
            }).catch((err) => {
                done(err);
            });
        });

        it('should return error', () => {
            const id = new mongoose.Types.ObjectId().toHexString();
            const error = new Error();
            mockingoose(Game).toReturn(error, 'findOneAndRemove');
            return GameController.deleteById(id).catch((err) => {
                expect(err).toBe(error);
            });
        });

        it('should return error when id does not exist', () => {
            const id = new mongoose.Types.ObjectId().toHexString();
            return GameController.deleteById(id).catch((err) => {
                expect(err).toEqual(new Error('Game id does not exist'));
            });
        });
    });

    describe('create', () => {
        let GameController;
        let Game;
        jest.isolateModules(() => {
            GameController = require('../../app/controllers/game');
            Game = require('../../app/models/game');
        });

        jest.mock('../../app/models/game', () => new MockModel());

        it('should create game when winner and loser are not the same', (done) => {
            const body = {
                winner: new mongoose.Types.ObjectId(),
                loser: new mongoose.Types.ObjectId(),
            };
            GameController.create(body).then(() => {
                expect(Game.create.mock.calls.length).toBe(1);
                expect(Game.create.mock.calls[0][0]).toBe(body);
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
            return GameController.create(body).catch((err) => {
                expect(Game.create.mock.calls.length).toBe(0);
                expect(err).toEqual(new Error('Winner and loser cannot be same player'));
            });
        });
    });

    describe('getAll', () => {
        let GameController;
        let Game;
        jest.isolateModules(() => {
            GameController = require('../../app/controllers/game');
            Game = require('../../app/models/game');
        });

        jest.mock('../../app/models/game', () => new MockModel());

        it('should get list of games', (done) => {
            GameController.getAll().then(() => {
                expect(Game.find.mock.calls.length).toBe(1);
                expect(Game.populate.mock.calls.length).toBe(2);
                expect(Game.populate.mock.calls[0][0]).toBe('winner');
                expect(Game.populate.mock.calls[1][0]).toBe('loser');
                expect(Game.exec.mock.calls.length).toBe(1);
                done();
            }).catch((err) => {
                done(err);
            });
        });
    });
});
