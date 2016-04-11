fs = require 'fs'
express = require 'express'
path = require 'path'
favicon = require 'serve-favicon'
logger = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
mongoose = require 'mongoose'
mongoose.connect 'mongodb://localhost/node-coffee-mongo-react'

browserify = require 'browserify'
coffeeify = require 'coffeeify'
reactify = require 'reactify'
bundle = browserify
  extensions: ['.coffee']
  debug: true
bundle.transform coffeeify,
  bare: false
  header: true
bundle.transform reactify
bundle.add(path.join(__dirname, 'public', 'javascripts', 'main.coffee'))
bundle.bundle (err, buf) ->
  stream = fs.createWriteStream(path.join(__dirname, 'public', 'javascripts', 'main.js'))
  stream.write(buf)
  stream.end()

# Bootstrap models
models = path.join(__dirname, 'models')
fs.readdirSync(models).filter((file) ->
  ~file.search(/^[^\.].*\.js$/)
).forEach (file) ->
  require path.join(models, file)

routes = require('./routes/index')
users = require('./routes/users')
node_types = require('./routes/node_types')
app = express()

# view engine setup
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'

# uncomment after placing your favicon in /public
#app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));

app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use cookieParser()

app.use require('node-sass-middleware')(
  src: path.join(__dirname, 'public')
  dest: path.join(__dirname, 'public')
  indentedSyntax: true
  sourceMap: true)

app.use express.static(path.join(__dirname, 'public'))

app.use '/', routes
app.use '/users', users
app.use '/node_types', node_types

# catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error('Not Found')
  err.status = 404
  next err

# error handlers
# development error handler
# will print stacktrace
if app.get('env') == 'development'
  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.render 'error',
      message: err.message
      error: err

# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
  res.status err.status or 500
  res.render 'error',
    message: err.message
    error: {}

module.exports = app

