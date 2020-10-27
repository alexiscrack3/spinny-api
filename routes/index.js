const express = require('express');
const authRouter = require('./auth');
const feedbackRouter = require('./feedback');
const playerRouter = require('./players');
const clubRouter = require('./clubs');
const gameRouter = require('./games');

const indexRouter = express.Router();

indexRouter
    .get('/', (req, res) => {
        res.send('Hello World!');
    })
    .use((req, res, next) => {
        res.set('X-Correlation-Id', req.correlationId());
        next();
    });

module.exports = {
    '/': indexRouter,
    '/auth': authRouter,
    '/feedback': feedbackRouter,
    '/players': playerRouter,
    '/clubs': clubRouter,
    '/games': gameRouter,
};
