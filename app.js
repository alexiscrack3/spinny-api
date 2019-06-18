const express = require('express');
const middlewares = require('./middlewares');

const routes = require('./app/routes/users');

const app = express();

for (const key in middlewares) {
    app.use(middlewares[key]);
}

app.use('/', routes);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
    next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};

    // render the error page
    res.status(err.status || 500);
    res.render('error', { title: 'error' });
});

module.exports = app;
