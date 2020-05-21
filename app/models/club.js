const mongoose = require('mongoose');

const { Schema } = mongoose;

const clubSchema = new Schema({
    created_at: { type: Date, default: Date.now },
    name: {
        type: String,
        required: true,
        trim: true,
        unique: true,
    },
    members: [{ type: Schema.Types.ObjectId, ref: 'Player' }],
});

const Club = mongoose.model('Club', clubSchema);

module.exports = Club;
