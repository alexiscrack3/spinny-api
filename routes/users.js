const express = require('express');
const UsersController = require('../app/controllers/users')
var router = express.Router();

router.get('/', function (req, res, next) {
    UsersController.getUsers((err, users) => {
        res.json(users);
    });
});

module.exports = router;
