const express = require('express');
const sgMail = require('@sendgrid/mail');
const AuthRoutes = require('../app/routes/auth');
const FeedbackController = require('../app/controllers/feedback');
const FeedbackRoutes = require('../app/routes/feedback');
const EmailService = require('../app/services/email');
const PlayersController = require('../app/controllers/players');
const PlayerRoutes = require('../app/routes/player');
const Player = require('../app/models/player');
const GamesController = require('../app/controllers/games');
const GameRoutes = require('../app/routes/game');
const Game = require('../app/models/game');
const ClubsController = require('../app/controllers/clubs');
const ClubRoutes = require('../app/routes/club');
const Club = require('../app/models/club');

require('../app/helpers/passport');

const indexRouter = express.Router();
const authRouter = express.Router();

const emailService = new EmailService(sgMail);
const feedbackController = new FeedbackController(emailService);
const feedbackRoutes = new FeedbackRoutes(feedbackController);
const feedbackRouter = express.Router();

const playersController = new PlayersController(Player);
const playerRoutes = new PlayerRoutes(playersController);
const playerRouter = express.Router();

const gamesController = new GamesController(Game);
const gameRoutes = new GameRoutes(gamesController);
const gameRouter = express.Router();

const clubsController = new ClubsController(Club);
const clubRoutes = new ClubRoutes(clubsController);
const clubRouter = express.Router();

indexRouter.get('/', (req, res) => {
    res.send('Hello World!');
});

authRouter.post('/sign_up', AuthRoutes.signUp);
authRouter.post('/sign_in', AuthRoutes.signIn);

feedbackRouter.post('/feedback', (req, res) => feedbackRoutes.send(req, res));

playerRouter
    .get('/', (req, res) => playerRoutes.getAll(req, res))
    .get(
        '/me',
        AuthRoutes.authenticate,
        (req, res) => playerRoutes.getProfile(req, res),
    )
    .get('/:id', (req, res) => playerRoutes.getById(req, res))
    .put('/:id', (req, res) => playerRoutes.updateById(req, res));

gameRouter
    .get('/', (req, res) => gameRoutes.getAll(req, res))
    .post('/', (req, res) => gameRoutes.create(req, res))
    .delete('/:id', (req, res) => gameRoutes.deleteById(req, res));

clubRouter
    .get('/', (req, res) => clubRoutes.getAll(req, res))
    .get('/:id', (req, res) => clubRoutes.getById(req, res))
    .post('/', (req, res) => clubRoutes.create(req, res))
    .put('/:id/players', (req, res) => clubRoutes.addPlayer(req, res));

module.exports = {
    '/': indexRouter,
    '/auth': authRouter,
    '/feedback': feedbackRouter,
    '/players': playerRouter,
    '/games': gameRouter,
    '/clubs': clubRouter,
};
