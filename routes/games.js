const express = require('express');
const Game = require('../app/models/game');
const GamesRepository = require('../app/repositories/games');
const GamesController = require('../app/controllers/games');

const gamesRepository = new GamesRepository(Game);
const gamesController = new GamesController(gamesRepository);
const gameRouter = express.Router();

gameRouter
    .get('/', (req, res) => gamesController.getAll(req, res))
    .post('/', (req, res) => gamesController.create(req, res))
    .delete('/:id', (req, res) => gamesController.deleteById(req, res));

module.exports = gameRouter;
