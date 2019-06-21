const express = require('express');
const PlayersController = require('../app/controllers/players')
var router = express.Router();

router.get('/', function (req, res, next) {
    PlayersController.getPlayers((err, players) => {
        res.json(players);
    });
});

module.exports = router;
