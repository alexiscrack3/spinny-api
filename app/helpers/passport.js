const LocalStrategy = require('passport-local').Strategy;
const JwtStrategy = require('passport-jwt').Strategy;
const { ExtractJwt } = require('passport-jwt');
const passport = require('passport');
const PlayersController = require('../controllers/players');

// we are using named strategies since we have one for login and one for signup
// by default, if there was no name, it would just be called 'local'
passport.use('local-login', new LocalStrategy({
    // by default, local strategy uses username and password, we will override with email
    usernameField: 'email',
    passwordField: 'password',
    passReqToCallback: true, // allows us to pass back the entire request to the callback
    session: false,
}, (req, email, password, done) => {
    // PlayersController.getByEmail wont fire unless data is sent back
    process.nextTick(() => {
        // find a user whose email is the same as the forms email
        // we are checking to see if the user trying to login already exists
        PlayersController.getByEmail(email)
            .then((user) => {
                // if no user is found, return the message
                if (!user) {
                    done(null, false, {
                        message: 'Player not found.',
                    }); // An additional info message can be supplied to indicate the reason for the failure. This is useful for displaying a flash message prompting the user to try again.
                }

                // if the user is found but the password is wrong
                if (!user.validPassword(password)) {
                    done(null, false, {
                        message: 'Wrong password.',
                    });
                }

                // all is well, return successful user
                done(null, user);
            })
            .catch((err) => {
                // if there are any errors, return the error before anything else
                done(err);
            });
    });
}));

passport.use('local-signup', new LocalStrategy({
    usernameField: 'email',
    passwordField: 'password',
    passReqToCallback: true,
    session: false,
}, (req, email, password, done) => {
    process.nextTick(() => {
        if (email && password) {
            const emailRegex = /^([A-Za-z0-9_\-.+])+@([A-Za-z0-9_\-.])+\.([A-Za-z]{2,})$/;
            if (emailRegex.test(email)) {
                PlayersController.getByEmail(email)
                    .then((player) => {
                        if (player) {
                            throw new Error('Email already exists');
                        } else {
                            return PlayersController.create(req.body);
                        }
                    })
                    .then((player) => {
                        if (player) {
                            done(null, player);
                        }
                    })
                    .catch((err) => {
                        done(err, null);
                    });
            } else {
                const err = new Error('Request could not be completed.');
                done(err, null);
            }
        } else {
            const err = new Error('Request could not be completed.');
            done(err, null);
        }
    });
}));

passport.use(new JwtStrategy({
    jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
    secretOrKey: process.env.SECRET_KEY,
}, (jwtPayload, done) => {
    PlayersController.getById(jwtPayload.id)
        .then((player) => {
            done(null, player);
        })
        .catch((err) => {
            done(err, null);
        });
}));
