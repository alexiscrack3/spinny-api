const Roster = require('../models/roster');

exports.create = body => Roster.create(body);

exports.getAll = () => Roster.find()
    .populate('club')
    .populate({
        path: 'player',
        select: 'email',
        // select: 'email -_id',
    })
    .exec();
