const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const playerSchema = new Schema({
    // firstName: String,
    // middleName: String,
    // lastName: String,
    email: {
        type: String,
        index: true,
        required: true,
        unique: true
    },
    password: String,
    rating: { type: Number, default: 1000 },
});

var Player = mongoose.model('Player', playerSchema);

module.exports = Player;
