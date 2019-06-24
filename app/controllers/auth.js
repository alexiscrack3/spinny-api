const LocalStrategy = require('passport-local').Strategy;
const jwt = require('jsonwebtoken');
const passport = require('passport');
// const debug = require('debug')('spinny:server');
// const Player = require('../models/player');
const PlayersController = require('./players');

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

// we are using named strategies since we have one for login and one for signup
// by default, if there was no name, it would just be called 'local'

// passport.use('local-signup', new LocalStrategy({
//     // by default, local strategy uses username and password, we will override with email
//     usernameField: 'email',
//     passwordField: 'password',
//     passReqToCallback: true, // allows us to pass back the entire request to the callback
// }, (req, email, password, done) => {
//     // PlayersController.getPlayerByEmail wont fire unless data is sent back
//     process.nextTick(() => {
//         // find a user whose email is the same as the forms email
//         // we are checking to see if the user trying to login already exists
//         PlayersController.getPlayerByEmail(email, (err, user) => {
//             // if there are any errors, return the error
//             if (err) done(err);

//             // check to see if theres already a user with that email
//             if (user) {
//                 done(null, false, req.flash('signupMessage', 'That email is already taken.'));
//             } else {
//                 // if there is no user with that email
//                 // create the user
//                 var newUser = new Player();

//                 // set the user's credentials
//                 newUser.email = email;
//                 newUser.password = password;

//                 // save the user
//                 PlayersController.create(newUser, (err) => {
//                     if (err) throw err;

//                     return done(null, newUser);
//                 });
//             }
//         });
//     });
// }));
