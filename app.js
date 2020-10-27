const express = require('express');
const debug = require('debug')('spinny:app');
const middlewares = require('./middlewares');
const routes = require('./routes');
const database = require('./db');

const app = express();

Object.keys(middlewares).forEach((key) => {
    app.use(middlewares[key]);
});

Object.keys(routes).forEach((path) => {
    app.use(path, routes[path]);
});

if (process.env.NODE_ENV !== 'test') {
    database.connect().catch((err) => {
        if (err) {
            process.exit(1);
        }
    });
}

// catch 404 and forward to error handler
app.use((req, res, next) => {
    const body = {
        timestamp: new Date().toISOString(),
        status: 404,
        error: 'Not Found',
        message: '',
        path: req.path,
    };
    res.status(404).json(body);
    next();
});

function gracefulExit() {
    debug('Caught interrupt signal');
    database.close().then(() => {
        process.exit();
    });
}

process
    .on('SIGINT', gracefulExit)
    .on('SIGTERM', gracefulExit)
    .on('exit', (code) => {
        debug(`Exit with ${code} code`);
    });

module.exports = app;
