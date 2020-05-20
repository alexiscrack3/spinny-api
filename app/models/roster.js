const mongoose = require('mongoose');

const { Schema } = mongoose;

const rosterSchema = new Schema({
    created_at: { type: Date, default: Date.now },
    club: { type: Schema.Types.ObjectId, ref: 'Club', required: true },
    player: { type: Schema.Types.ObjectId, ref: 'Player', required: true },
});

const Roster = mongoose.model('Roster', rosterSchema);

module.exports = Roster;
