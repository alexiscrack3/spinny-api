const Player = require('../models/player');

exports.getAll = () => Player.find({});

exports.getById = id => Player.findById(id);

exports.getByEmail = email => Player.findOne({ email });

exports.create = body => Player.create(body);
