mongoose = require 'mongoose'

User = mongoose.model 'User'

create = (req, res, next) ->
    User.register req.body.username, req.body.password, (err, user) ->
        return next(err) if err
        res.locals(user.toObjectSafe())
        res.status(201)
        next()

login = (req, res, next) ->
    User.verify req.body.username, req.body.password, (err, user) ->
        if err
            res.status(401)
            return next(new Error("Invalid credentials"))
        req.session.user = user
        res.locals(user)
        next()



#### ---------------------------------------------------------------------- ###

module.exports = {
    create
    login
}
