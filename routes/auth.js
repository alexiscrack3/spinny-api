const express = require('express');
const AuthController = require('../app/controllers/auth');

const authRouter = express.Router();

authRouter.post('/sign_up', AuthController.signUp);
authRouter.post('/sign_in', AuthController.signIn);

module.exports = authRouter;
