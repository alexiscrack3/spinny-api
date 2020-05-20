const MockModel = require('jest-mongoose-mock');
const ClubController = require('../../app/controllers/club');
const Club = require('../../app/models/club');

jest.mock('../../app/models/club', () => new MockModel());

describe('club controller', () => {
    beforeEach(() => {
        jest.clearAllMocks();
    });

    describe('create', () => {
        it('should create club', (done) => {
            const body = {
                name: 'club',
            };
            ClubController.create(body).then(() => {
                expect(Club.create.mock.calls.length).toBe(1);
                expect(Club.create.mock.calls[0][0]).toBe(body);
                done();
            }).catch((err) => {
                done(err);
            });
        });
    });

    describe('getAll', () => {
        it('should get players', (done) => {
            ClubController.getAll().then(() => {
                expect(Club.find.mock.calls.length).toBe(1);
                done();
            }).catch((err) => {
                done(err);
            });
        });
    });
});
