var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var eventsRouter = require('./routes/events');

var app = express();
const { auth } = require('express-openid-connect');const { fdatasync } = require('fs');
const db = require("./db/db")
jdja


const config = {
  authRequired: false,
  auth0Logout: true,
  secret: 'a long, randomly-generated string stored in env',
  baseURL: 'http://localhost:3000',
  clientID: '6NqMDxZkW25jX914Y8pemvRyrmTfewmI',
  issuerBaseURL: 'https://dev-4s47rktj.us.auth0.com'
};

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'hbs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/events', eventsRouter);
app.use(auth(config));

app.use(async  (req, res, next) => {
  res.locals = req.oidc.isAuthenticated();
  if (res.locals.isAuthenticated) {
    // check if admin
    let results = await db.queryPromise("SELECT admin FROM user WHERE email = ?", [req.oidc.user.email])
   if (results.length > )
   
    res.locals.isAdmin = results[0].admin == 1
  }
  next();

})


// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;




// auth router attaches /login, /logout, and /callback routes to the baseURL
// req.isAuthenticated is provided from the auth router
app.get('/', (req, res) => {
  res.send(req.oidc.isAuthenticated() ? 'Logged in' : 'Logged out');
});