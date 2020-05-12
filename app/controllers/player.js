const Player = require('../models/player');

exports.create = body => Player.create(body);

exports.getById = id => Player.findById(id);

exports.getByEmail = email => Player.findOne({ email });

exports.getAll = () => Player.find({});
