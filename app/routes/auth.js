const jwt = require('jsonwebtoken');
const passport = require('passport');
const APIError = require('./../models/api-error');
const APIResponse = require('./../models/api-response');

function authenticateUser(req, res, next, user) {
    req.login(user, { session: false }, (err) => {
        if (err) {
            res.status(500).json(new APIResponse(null, [
                new APIError('INTERNAL_ERROR', 'Something went wrong.'),
            ]));
        } else {
            next();
        }
    });
}

function authenticateUserAndExpediteToken(req, res, user) {
    req.login(user, { session: false }, (err) => {
        if (err) {
            res.status(500).json(new APIResponse(null, [
                new APIError('INTERNAL_ERROR', 'Something went wrong.'),
            ]));
        } else {
            // generate a signed son web token with the contents of user object and return it in the response
            const token = jwt.sign({ id: user.id }, process.env.SECRET_KEY, {
                expiresIn: 30, // seconds
            });
            res.json(new APIResponse({
                user,
                token,
            }));
        }
    });
}

exports.signUp = (req, res) => {
    passport.authenticate('local-signup', { session: false }, (err, user) => {
        if (err || !user) {
            res.status(400).json(new APIResponse(null, [
                new APIError('INTERNAL_ERROR', 'Bad request.'),
            ]));
        } else {
            authenticateUserAndExpediteToken(req, res, user);
        }
    })(req, res);
};

exports.signIn = (req, res) => {
    passport.authenticate('local-login', { session: false }, (err, user, info) => {
        if (err || !user) {
            res.status(400).json(new APIResponse(null, [
                new APIError('INTERNAL_ERROR', 'Bad request.'),
            ]));
        } else {
            authenticateUserAndExpediteToken(req, res, user);
        }
    })(req, res);
};

exports.authenticate = (req, res, next) => {
    passport.authenticate('jwt', { session: false }, (err, user, info) => {
        if (err) {
            res.status(500).json(new APIResponse(null, [
                new APIError('INTERNAL_ERROR', 'Something went wrong.'),
            ]));
        } else if (!user) {
            res.status(401).json(new APIResponse(null, [
                new APIError('UNAUTHORIZED', 'User is not authorized.'),
            ]));
        } else {
            authenticateUser(req, res, next, user);
        }
    })(req, res, next);
};
