const express = require('express');
const passport = require('passport');
const authController = require('../app/controllers/auth');
const passportController = require('../app/controllers/passport');
const playersController = require('../app/controllers/players');
const gamesController = require('../app/controllers/games');

const indexRouter = express.Router();
const authRouter = express.Router();
const playersRouter = express.Router();
const gamesRouter = express.Router();

indexRouter.get('/', (req, res) => {
    res.send('Hello World!');
});

// authRouter.post('/sign_up', authController.signUp);
authRouter.post('/sign_in', authController.signIn);

playersRouter
    .get('/', playersController.getAll)
    .get('/:id', passport.authenticate('jwt', { session: false }), playersController.getById)
    .post('/', playersController.create);

gamesRouter
    .get('/', gamesController.getAll)
    .post('/', gamesController.create);

module.exports = {
    '/': indexRouter,
    '/auth': authRouter,
    '/players': playersRouter,
    '/games': gamesRouter,
};
