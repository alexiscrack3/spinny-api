const mongoose = require('mongoose');
const MockModel = require('jest-mongoose-mock');
const RosterController = require('../../app/controllers/roster');
const Roster = require('../../app/models/roster');

jest.mock('../../app/models/roster', () => new MockModel());

describe('roster controller', () => {
    beforeEach(() => {
        jest.clearAllMocks();
    });

    describe('create', () => {
        it('should create roster', (done) => {
            const body = {
                club: new mongoose.Types.ObjectId(),
                player: new mongoose.Types.ObjectId(),
            };
            RosterController.create(body).then(() => {
                expect(Roster.create.mock.calls.length).toBe(1);
                expect(Roster.create.mock.calls[0][0]).toBe(body);
                done();
            }).catch((err) => {
                done(err);
            });
        });
    });

    describe('getAll', () => {
        it('should get list of all the players who belong to a particular team', (done) => {
            RosterController.getAll().then(() => {
                expect(Roster.find.mock.calls.length).toBe(1);
                expect(Roster.populate.mock.calls.length).toBe(2);
                expect(Roster.populate.mock.calls[0][0]).toBe('club');
                expect(Roster.populate.mock.calls[1][0]).toBe('player');
                expect(Roster.exec.mock.calls.length).toBe(1);
                done();
            }).catch((err) => {
                done(err);
            });
        });
    });
});
