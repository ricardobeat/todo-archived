
express  = require 'express'
mongoose = require 'mongoose'


# Database & models
# -----------------------------------------------------------------------------

mongoose.connect('mongodb://localhost/topdo')
mongoose.model 'User', require('./models/user')


# Controllers
# -----------------------------------------------------------------------------

api  = require './controllers/api'
user = require './controllers/user'


# Express server
# -----------------------------------------------------------------------------

app = express()

app.configure ->
    app.use express.bodyParser()
    app.use app.router
    app.use express.static "#{__dirname}/public"


# Routes
# -----------------------------------------------------------------------------

#### Static

app.get '/', (req, res) ->
    res.sendfile "views/index.html", { root: __dirname }

#### API

app.post '/user', user.create, api.json
app.post '/login', user.login, api.json

app.use api.error

if app.get('env') is 'development'
    app.use express.errorHandler dumpExceptions: true, showStack: true
else
    app.use express.errorHandler()

#### ---------------------------------------------------------------------- ###

unless module.parent
    app.listen 3000
    console.log "Listening on port 3000"

module.exports = app
