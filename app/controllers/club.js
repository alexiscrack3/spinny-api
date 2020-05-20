const Club = require('../models/club');

exports.create = body => Club.create(body);

exports.getAll = () => Club.find();
