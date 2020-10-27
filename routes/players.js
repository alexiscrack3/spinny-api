const express = require('express');
const AuthRoutes = require('../app/routes/auth');
const PlayersController = require('../app/controllers/players');
const PlayerRoutes = require('../app/routes/player');
const Player = require('../app/models/player');

const playersController = new PlayersController(Player);
const playerRoutes = new PlayerRoutes(playersController);
const playerRouter = express.Router();

playerRouter
    .get('/', (req, res) => playerRoutes.getAll(req, res))
    .get(
        '/me',
        AuthRoutes.authenticate,
        (req, res) => playerRoutes.getProfile(req, res),
    )
    .get('/:id', (req, res) => playerRoutes.getById(req, res))
    .put('/:id', (req, res) => playerRoutes.updateById(req, res));

module.exports = playerRouter;
