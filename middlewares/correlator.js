const correlator = require('express-correlation-id');

module.exports = correlator({
    header: 'x-correlation-id',
});
