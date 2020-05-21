const express = require('express');
const passport = require('passport');
const AuthRoutes = require('../app/routes/auth');
const PlayerRoutes = require('../app/routes/player');
const GameRoutes = require('../app/routes/game');
const ClubRoutes = require('../app/routes/club');

require('../app/helpers/passport');

const indexRouter = express.Router();
const authRouter = express.Router();
const playerRouter = express.Router();
const gameRouter = express.Router();
const clubRouter = express.Router();

indexRouter.get('/', (req, res) => {
    res.send('Hello World!');
});

authRouter.post('/sign_up', AuthRoutes.signUp);
authRouter.post('/sign_in', AuthRoutes.signIn);

playerRouter
    .get('/', PlayerRoutes.getAll)
    .get('/me', passport.authenticate('jwt', { session: false }), PlayerRoutes.getProfile)
    .get('/:id', PlayerRoutes.getById);

gameRouter
    .get('/', GameRoutes.getAll)
    .post('/', GameRoutes.create)
    .delete('/:id', GameRoutes.deleteById);

clubRouter
    .get('/', ClubRoutes.getAll)
    .post('/', ClubRoutes.create)
    .post('/:id/players', ClubRoutes.addPlayer);

module.exports = {
    '/': indexRouter,
    '/auth': authRouter,
    '/players': playerRouter,
    '/games': gameRouter,
    '/clubs': clubRouter,
};
