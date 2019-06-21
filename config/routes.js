const express = require('express');
const playersController = require('../app/controllers/players')
var indexRouter = express.Router();
var playersRouter = express.Router();

indexRouter.get('/', function (req, res, next) {
    res.send('Hello World!');
});

playersRouter
    .get('/', playersController.getAll)
    .get('/:id', playersController.getById)
    .post('/', playersController.create);

module.exports = {
    '/': indexRouter,
    '/players': playersRouter
};
