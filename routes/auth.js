const express = require('express');
const AuthRoutes = require('../app/routes/auth');

const authRouter = express.Router();

authRouter.post('/sign_up', AuthRoutes.signUp);
authRouter.post('/sign_in', AuthRoutes.signIn);

module.exports = authRouter;
