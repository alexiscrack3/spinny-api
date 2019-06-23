const mongoose = require('mongoose');

const { Schema } = mongoose;

const gameSchema = new Schema({
    created_at: { type: Date, default: Date.now },
    winner: { type: Schema.Types.ObjectId, ref: 'Player', required: true },
    looser: { type: Schema.Types.ObjectId, ref: 'Player', required: true },
});

const Game = mongoose.model('Game', gameSchema);

module.exports = Game;
