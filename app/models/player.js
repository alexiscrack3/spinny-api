const mongoose = require('mongoose');

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

const Player = mongoose.model('Player', playerSchema);

module.exports = Player;
