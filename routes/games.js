const express = require('express');
const GamesController = require('../app/controllers/games');
const GameRoutes = require('../app/routes/game');
const Game = require('../app/models/game');

const gamesController = new GamesController(Game);
const gameRoutes = new GameRoutes(gamesController);
const gameRouter = express.Router();

gameRouter
    .get('/', (req, res) => gameRoutes.getAll(req, res))
    .post('/', (req, res) => gameRoutes.create(req, res))
    .delete('/:id', (req, res) => gameRoutes.deleteById(req, res));

module.exports = gameRouter;
