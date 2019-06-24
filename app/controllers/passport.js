const LocalStrategy = require('passport-local').Strategy;
const JwtStrategy = require('passport-jwt').Strategy;
const { ExtractJwt } = require('passport-jwt');
const passport = require('passport');
const PlayersController = require('./players');

// we are using named strategies since we have one for login and one for signup
// by default, if there was no name, it would just be called 'local'

passport.use('local-login', new LocalStrategy({
    // by default, local strategy uses username and password, we will override with email
    usernameField: 'email',
    passwordField: 'password',
    passReqToCallback: true, // allows us to pass back the entire request to the callback
}, (req, email, password, done) => { // callback with email and password from our form
    // PlayersController.getPlayerByEmail wont fire unless data is sent back
    process.nextTick(() => {
        // find a user whose email is the same as the forms email
        // we are checking to see if the user trying to login already exists
        PlayersController.getPlayerByEmail(req, (err, user) => {
            // if there are any errors, return the error before anything else
            if (err) done(err);

            // if no user is found, return the message
            if (!user) {
                done(null, false, {
                    message: 'Player not found.',
                });
            }

            // if the user is found but the password is wrong
            if (!user.validPassword(password)) {
                done(null, false, {
                    message: 'Wrong password.',
                });
            }

            // all is well, return successful user
            // debug(`Session ID is ${req.sessionID}`);
            done(null, user);
        });
    });
}));

require('dotenv').config();
passport.use(new JwtStrategy({
    jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
    secretOrKey: process.env.SECRET_KEY,
}, (jwtPayload, cb) => {
    // find the user in db if needed. This functionality may be omitted if you store everything you'll need in JWT payload.
    PlayersController.getPlayerById(jwtPayload.id, (err, player) => {
        if (err) cb(err, null);
        else cb(null, player);
    });
}));
