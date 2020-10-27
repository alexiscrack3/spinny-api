const express = require('express');
const ClubsController = require('../app/controllers/clubs');
const ClubRoutes = require('../app/routes/club');
const Club = require('../app/models/club');

const clubsController = new ClubsController(Club);
const clubRoutes = new ClubRoutes(clubsController);
const clubRouter = express.Router();

clubRouter
    .get('/', (req, res) => clubRoutes.getAll(req, res))
    .get('/:id', (req, res) => clubRoutes.getById(req, res))
    .post('/', (req, res) => clubRoutes.create(req, res))
    .put('/:id/players', (req, res) => clubRoutes.addPlayer(req, res));

module.exports = clubRouter;
