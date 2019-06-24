const jwt = require('jsonwebtoken');
const passport = require('passport');

exports.signIn = (req, res) => {
    passport.authenticate('local-login', { session: false }, (err, user, info) => {
        if (err || !user) {
            res.status(400).json({
                message: 'Something is not right',
                user,
            });
        } else {
            req.login(user, { session: false }, (err) => {
                if (err) res.send(err);

                // generate a signed son web token with the contents of user object and return it in the response
                const token = jwt.sign({ id: user.id }, process.env.SECRET_KEY);
                res.json({ user, token });
            });
        }
    })(req, res);
};
