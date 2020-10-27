const express = require('express');
const Club = require('../app/models/club');
const ClubsRepository = require('../app/repositories/clubs');
const ClubsController = require('../app/controllers/clubs');

const clubsRepository = new ClubsRepository(Club);
const clubsController = new ClubsController(clubsRepository);
const clubRouter = express.Router();

clubRouter
    .get('/', (req, res) => clubsController.getAll(req, res))
    .get('/:id', (req, res) => clubsController.getById(req, res))
    .post('/', (req, res) => clubsController.create(req, res))
    .put('/:id/players', (req, res) => clubsController.addPlayer(req, res));

module.exports = clubRouter;
