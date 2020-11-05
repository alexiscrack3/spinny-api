const winston = require('winston');

const { createLogger, format, transports } = winston;
const { combine, timestamp, prettyPrint } = format;

const options = {
    console: {
        level: 'debug',
        handleExceptions: true,
        json: false,
        colorize: true,
    },
    error: {
        level: 'error',
        filename: 'error.log',
    },
    combined: {
        filename: 'combined.log',
    },
};

const logger = createLogger({
    level: 'info',
    format: combine(
        timestamp(),
        prettyPrint(),
    ),
    transports: [
        new transports.Console(options.console),
        // - Write all logs with level `error` and below to `error.log`
        new winston.transports.File(options.error),
        // - Write all logs with level `info` and below to `combined.log`
        new winston.transports.File(options.combined),
    ],
});

//
// If we're not in production then log to the `console` with the format:
// `${info.level}: ${info.message} JSON.stringify({ ...rest }) `
//
if (process.env.NODE_ENV !== 'production') {
    logger.add(new winston.transports.Console({
        format: format.simple(),
    }));
}

module.exports = logger;
