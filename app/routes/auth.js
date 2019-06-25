const jwt = require('jsonwebtoken');
const passport = require('passport');
const PlayerController = require('../controllers/player');

function authenticateUser(req, res, user) {
    req.login(user, { session: false }, (err) => {
        if (err) {
            res.status(500).json({
                error: {
                    status: 500,
                    message: 'Request could not be completed.',
                },
            });
        }

        // generate a signed son web token with the contents of user object and return it in the response
        const token = jwt.sign({ id: user.id }, process.env.SECRET_KEY, {
            expiresIn: 30, // seconds
        });
        res.json({
            data: {
                user,
                token,
            },
        });
    });
}

exports.signUp = (req, res) => {
    const { email, password } = req.body;
    if (email && password) {
        const emailRegex = /^([A-Za-z0-9_\-.+])+@([A-Za-z0-9_\-.])+\.([A-Za-z]{2,})$/;
        if (emailRegex.test(email)) {
            PlayerController.getByEmail(email)
                .then((player) => {
                    if (player) {
                        throw new Error('Email already exists');
                    } else {
                        return PlayerController.create(req.body);
                    }
                })
                .then((player) => {
                    if (player) {
                        authenticateUser(req, res, player);
                    }
                })
                .catch(() => {
                    res.status(500).json({
                        error: {
                            status: 500,
                            message: 'Request could not be completed.',
                        },
                    });
                });
        } else {
            res.status(422).json({
                error: {
                    status: 422,
                    message: 'Request could not be completed.',
                },
            });
        }
    } else {
        res.status(400).json({
            error: {
                status: 400,
                message: 'Request could not be completed.',
            },
        });
    }
};

exports.signIn = (req, res) => {
    passport.authenticate('local-login', { session: false }, (err, user, info) => {
        if (err || !user) {
            res.status(400).json({
                error: {
                    status: 400,
                    message: 'Bad request.',
                },
            });
        } else {
            authenticateUser(req, res, user);
        }
    })(req, res);
};
