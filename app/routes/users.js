const express = require('express');
const UsersController = require('../controllers/users')
var router = express.Router();

router.get('/', function (req, res, next) {
    UsersController.getUsers((err, users) => {
        console.log('ERR = ' + err)
        console.log('USERS = ' + users)
        res.json(users);
    });
});

module.exports = router;
