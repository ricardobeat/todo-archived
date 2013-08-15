
express = require 'express'

app = express()

app.configure ->
    app.use express.bodyParser()
    app.use app.router
    app.use express.static "#{__dirname}/public"

    if app.get('env') is 'development'
        app.use express.errorHandler dumpExceptions: true, showStack: true
    else
        app.use express.errorHandler()

app.get '/', (req, res) ->
    res.sendfile "views/index.html", { root: __dirname }

unless module.parent
    app.listen 3000
    console.log "Listening on port 3000"

module.exports = app
