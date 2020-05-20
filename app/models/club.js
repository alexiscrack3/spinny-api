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
});

const Club = mongoose.model('Club', clubSchema);

module.exports = Club;
