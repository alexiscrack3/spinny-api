const mongoose = require('mongoose');
const Schema = mongoose.Schema;

var userSchema = new Schema({
    firstName: String,
    middleName: String,
    lastName: String,
    email: {
        type: String,
        index: true,
        required: true,
        unique: true
    },
    password: String
});

var User = mongoose.model('User', userSchema);

module.exports = User;
