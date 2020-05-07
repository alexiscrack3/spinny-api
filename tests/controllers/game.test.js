const MockModel = require('jest-mongoose-mock');
const GameController = require('../../app/controllers/game');
const Game = require('../../app/models/game');

jest.mock('../../app/models/game', () => new MockModel());

describe('game controller', () => {
    beforeEach(() => {
        jest.clearAllMocks();
    });

    describe('create', () => {
        it('should create game when winner and loser are not the same', (done) => {
            const body = {
                winner: 1,
                loser: 2,
            };
            GameController.create(body).then(() => {
                expect(Game.create.mock.calls.length).toBe(1);
                expect(Game.create.mock.calls[0][0]).toBe(body);
                done();
            }).catch(() => {
                done();
            });
        });

        it('should not create game when winner and loser are the same', (done) => {
            const id = 1;
            const body = {
                winner: id,
                loser: id,
            };
            GameController.create(body).then(() => {
                expect(Game.create.mock.calls.length).toBe(0);
                done();
            }).catch(() => {
                done();
            });
        });
    });

    it('gets games', (done) => {
        GameController.getAll().then(() => {
            expect(Game.find.mock.calls.length).toBe(1);
            expect(Game.populate.mock.calls.length).toBe(2);
            expect(Game.populate.mock.calls[0][0]).toBe('winner');
            expect(Game.populate.mock.calls[1][0]).toBe('loser');
            expect(Game.exec.mock.calls.length).toBe(1);
            done();
        }).catch(() => {
            done();
        });
    });
});
