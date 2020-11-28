const express = require('express');
const multer = require('../app/helpers/multer');
const AuthController = require('../app/controllers/auth');
const Player = require('../app/models/player');
const PlayersRepository = require('../app/repositories/players');
const PlayersController = require('../app/controllers/players');

const playersRepository = new PlayersRepository(Player);
const playersController = new PlayersController(playersRepository);
const playerRouter = express.Router();

playerRouter
    .get('/', (req, res) => playersController.getAll(req, res))
    .get(
        '/me',
        AuthController.authenticate,
        (req, res) => playersController.getProfile(req, res),
    )
    .get('/:id', (req, res) => playersController.getById(req, res))
    .put('/:id', (req, res) => playersController.updateById(req, res))
    .post('/:id/upload', multer.single('file'), (req, res) => playersController.updateProfileImage(req, res));

module.exports = playerRouter;
