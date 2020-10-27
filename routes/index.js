const express = require('express');
const authRouter = require('./auth');
const feedbackRouter = require('./feedback');
const playerRouter = require('./players');
const clubRouter = require('./clubs');
const gameRouter = require('./games');

require('../app/helpers/passport');

const indexRouter = express.Router();

indexRouter
    .get('/', (req, res) => { res.send('Hello World!'); });

module.exports = {
    '/': indexRouter,
    '/auth': authRouter,
    '/feedback': feedbackRouter,
    '/players': playerRouter,
    '/games': gameRouter,
    '/clubs': clubRouter,
};
