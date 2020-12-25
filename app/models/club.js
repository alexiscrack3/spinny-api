const mongoose = require('mongoose');

const { Schema } = mongoose;

const opts = {
    id: false, // disables id virtual getter
    timestamps: {
        createdAt: 'created_at',
        updatedAt: 'updated_at',
    },
    toJSON: { virtuals: true }, // includes virtuals when you convert a document to JSON
};
const clubSchema = new Schema({
    name: {
        type: String,
        required: true,
        trim: true,
        unique: true,
    },
    members: [{ type: Schema.Types.ObjectId, ref: 'Player' }],
}, opts);

clubSchema.virtual('members_count').get(function () {
    return this.members.length;
});

const Club = mongoose.model('Club', clubSchema);

module.exports = Club;
