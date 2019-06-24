const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const saltRounds = 8;
const { Schema } = mongoose;

const playerSchema = new Schema({
    // firstName: String,
    // middleName: String,
    // lastName: String,
    email: {
        type: String,
        index: true,
        required: true,
        unique: true,
    },
    password: String,
    rating: { type: Number, default: 1000 },
});

playerSchema.pre('save', function (next) {
    const player = this;

    if (!player.isNew && !player.isModified('password')) {
        next();
    }

    player.generateHash(player.password, (err, hash) => {
        if (err) next(err);
        else {
            player.password = hash;
            next();
        }
    });
});

playerSchema.methods.generateHash = (password, callback) => {
    bcrypt.genSalt(saltRounds, (err, salt) => {
        if (err) callback(err, null);

        bcrypt.hash(password, salt, (err, hash) => {
            if (err) callback(err, null);

            callback(null, hash);
        });
    });
};

playerSchema.methods.generateHashSync = (password) => {
    const salt = bcrypt.genSaltSync(saltRounds);
    bcrypt.hashSync(password, salt);
};

playerSchema.methods.validPassword = function (password) {
    return bcrypt.compareSync(password, this.password);
};

const Player = mongoose.model('Player', playerSchema);

module.exports = Player;
