mongoose = require 'mongoose'

User = mongoose.model 'User'

create = (req, res, next) ->
    User.register req.body.username, req.body.password, (err, user) ->
        return next(err) if err
        res.locals(user.toObjectSafe())
        res.status(201)
        next()

login = (req, res, next) ->


#### ---------------------------------------------------------------------- ###

module.exports = {
    create
    login
}
