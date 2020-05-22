const mongoose = require('mongoose');
const sinon = require('sinon');
const PlayersController = require('../../app/controllers/players');
const Player = require('../../app/models/player');

describe('players controller', () => {
    beforeEach(() => {
        sinon.restore();
    });

    describe('create', () => {
        it('should create player', (done) => {
            const body = {
                email: 'user@spinny.com',
            };
            const playerMock = sinon.mock(Player);
            playerMock
                .expects('create')
                .withArgs(body)
                .resolves(body);

            const playersController = new PlayersController(Player);
            playersController.create(body).then((player) => {
                playerMock.verify();
                playerMock.restore();
                expect(body).toBe(player);
                done();
            }).catch((err) => {
                done(err);
            });
        });

        it('should return error', (done) => {
            const body = {
                email: 'user@spinny.com',
            };
            const playerMock = sinon.mock(Player);
            playerMock
                .expects('create')
                .withArgs(body)
                .returns(Promise.reject());

            const playersController = new PlayersController(Player);
            playersController.create(body).then(() => {
                done();
            }).catch((err) => {
                playerMock.verify();
                playerMock.restore();
                done(err);
            });
        });
    });

    describe('getById', () => {
        it('should get player by id', (done) => {
            const id = new mongoose.Types.ObjectId();
            const body = {
                _id: id,
                email: 'user@spinny.com',
            };
            const playerMock = sinon.mock(Player);
            playerMock
                .expects('findById')
                .withArgs(id.toHexString())
                .resolves(body);

            const playersController = new PlayersController(Player);
            playersController.getById(id.toHexString()).then((player) => {
                playerMock.verify();
                playerMock.restore();
                expect(body).toBe(player);
                done();
            }).catch((err) => {
                done(err);
            });
        });

        it('should return error', (done) => {
            const id = new mongoose.Types.ObjectId();
            const playerMock = sinon.mock(Player);
            playerMock
                .expects('findById')
                .withArgs(id.toHexString())
                .returns(Promise.reject());

            const playersController = new PlayersController(Player);
            playersController.getById(id.toHexString()).then(() => {
                done();
            }).catch((err) => {
                playerMock.verify();
                playerMock.restore();
                done(err);
            });
        });
    });

    describe('getByEmail', () => {
        it('should get player by email', (done) => {
            const body = {
                email: 'user@spinny.com',
            };
            const playerMock = sinon.mock(Player);
            playerMock
                .expects('findOne')
                .withArgs({ email: body.email })
                .resolves(body);

            const playersController = new PlayersController(Player);
            playersController.getByEmail(body.email).then((player) => {
                playerMock.verify();
                playerMock.restore();
                expect(body).toBe(player);
                done();
            }).catch((err) => {
                done(err);
            });
        });

        it('should return error', (done) => {
            const body = {
                email: 'user@spinny.com',
            };
            const playerMock = sinon.mock(Player);
            playerMock
                .expects('findOne')
                .withArgs({ email: body.email })
                .returns(Promise.reject());

            const playersController = new PlayersController(Player);
            playersController.getByEmail(body.email).then(() => {
                done();
            }).catch((err) => {
                playerMock.verify();
                playerMock.restore();
                done(err);
            });
        });
    });

    describe('getAll', () => {
        it('should get players', (done) => {
            const body = {
                email: 'user@spinny.com',
            };
            const results = [body];
            const playerMock = sinon.mock(Player);
            playerMock
                .expects('find')
                .resolves(results);

            const playersController = new PlayersController(Player);
            playersController.getAll().then((players) => {
                playerMock.verify();
                playerMock.restore();
                expect(results).toBe(players);
                done();
            }).catch((err) => {
                done(err);
            });
        });

        it('should return error', (done) => {
            const body = {
                email: 'user@spinny.com',
            };
            const results = [body];
            const playerMock = sinon.mock(Player);
            playerMock
                .expects('find')
                .resolves(results);

            const playersController = new PlayersController(Player);
            playersController.getAll().then(() => {
                done();
            }).catch((err) => {
                playerMock.verify();
                playerMock.restore();
                done(err);
            });
        });
    });
});
