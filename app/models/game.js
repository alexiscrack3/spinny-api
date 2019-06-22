const mongoose = require('mongoose');

const { Schema } = mongoose;

const gameSchema = new Schema({
    winnerId: { type: Schema.Types.ObjectId, ref: 'Player', required: true },
    looserId: { type: Schema.Types.ObjectId, ref: 'Player', required: true },
});

const Game = mongoose.model('Game', gameSchema);

module.exports = Game;
