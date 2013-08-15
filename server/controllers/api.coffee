_ = require 'underscore'

# API response formatters
# -----------------------------------------------------------------------------

json = (req, res) ->
    res.json _.extend {}, res.locals

# Error-catching middleware. Makes sure status code is set correctly,
# normalizes error responses.

error = (err, req, res, next) ->
    res.status(500) if res.statusCode < 400
    res.send {
        code    : res.statusCode
        message : err.message
    }

#### ---------------------------------------------------------------------- ###

module.exports = {
    json
    error
}
