const express = require('express');
const playersController = require('../app/controllers/players');
const gamesController = require('../app/controllers/games');

const indexRouter = express.Router();
const playersRouter = express.Router();
const gamesRouter = express.Router();

indexRouter.get('/', (req, res) => {
    res.send('Hello World!');
});

playersRouter
    .get('/', playersController.getAll)
    .get('/:id', playersController.getById)
    .post('/', playersController.create);

gamesRouter
    .get('/', gamesController.getAll)
    .post('/', gamesController.create);

module.exports = {
    '/': indexRouter,
    '/players': playersRouter,
    '/games': gamesRouter,
};
