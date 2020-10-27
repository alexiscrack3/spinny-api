const correlator = require('express-correlation-id');

module.exports = correlator({
    header: 'X-Correlation-Id',
});
