const jwt = require('jsonwebtoken');
const passport = require('passport');

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
                res.json({ user, token });
            });
        }
    })(req, res);
};
