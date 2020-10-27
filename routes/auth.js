const express = require('express');
const AuthController = require('../app/controllers/auth');

const authController = new AuthController();
const authRouter = express.Router();

require('../app/helpers/passport');

authRouter.post('/sign_up', authController.signUp);
authRouter.post('/sign_in', authController.signIn);

module.exports = authRouter;
