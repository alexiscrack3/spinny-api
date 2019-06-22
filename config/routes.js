const express = require('express');
const playersController = require('../app/controllers/players');

const indexRouter = express.Router();
const playersRouter = express.Router();

indexRouter.get('/', (req, res) => {
    res.send('Hello World!');
});

playersRouter
    .get('/', playersController.getAll)
    .get('/:id', playersController.getById)
    .post('/', playersController.create);

module.exports = {
    '/': indexRouter,
    '/players': playersRouter,
};
