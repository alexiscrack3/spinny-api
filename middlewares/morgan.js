const morgan = require('morgan');

let logger = (err, res, next) => { next(); };
if (process.env.NODE_ENV !== 'test') {
    logger = morgan('dev');
}

module.exports = logger;
