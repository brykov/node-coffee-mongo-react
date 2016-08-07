fs = require 'fs'
express = require 'express'
path = require 'path'
favicon = require 'serve-favicon'
logger = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
bluebird = require 'bluebird'
mincer = require 'mincer'
require('mincer-jsx')(mincer)
mongoose = require 'mongoose'
mongoose.Promise = bluebird
mongoose.connect 'mongodb://localhost/node-coffee-mongo-react'
uglifyjs = require 'uglify-js'

# Bootstrap models
models = path.join(__dirname, 'models')
fs.readdirSync(models).filter((file) ->
  ~file.search(/^[^\.].*\.js$/)
).forEach (file) ->
  require path.join(models, file)

routes = require('./routes/index')
users = require('./routes/users')
meta_list = require('./routes/meta_list')
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


#mincer.logger.level(4)
environment = new mincer.Environment()
environment.appendPath('assets/javascripts')
environment.appendPath('assets/stylesheets')
#environment.jsCompressor = 'uglify' #js['Compressor']
app.use('/assets', mincer.createServer(environment))

#app.use require('node-sass-middleware')(
#  src: path.join(__dirname, 'public')
#  dest: path.join(__dirname, 'public')
#  indentedSyntax: true
#  sourceMap: true)

app.use express.static(path.join(__dirname, 'public'))

app.use '/', routes
app.use '/users', users
app.use '/meta_list', meta_list

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

