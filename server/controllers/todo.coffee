mongoose = require 'mongoose'
_        = require 'underscore'

Todo = mongoose.model 'Todo'

list = (req, res, next) ->
    Todo.find { user: req.session.user._id }, (err, items) ->
        return next(err) if err
        res.locals { items }
        next()


create = (req, res, next) ->
    data = _.extend req.body, { user: req.session.user._id }
    Todo.create data, (err, todo) ->
        return next(err) if err
        res.locals todo.toObjectSafe()
        res.status(201)
        next()

edit = (req, res, next) ->
    Todo.findOneAndUpdate {
        _id: req.params.id
        user: req.session.user._id
    }, _.omit(req.body, '_id'), (err, todo) ->
        console.log err, todo
        return next(err) if err
        res.locals todo.toObjectSafe()
        next()

destroy = (req, res, next) ->
    Todo.findOneAndRemove {
        _id: req.params.id
        user: req.session.user._id
    }, (err) ->
        return next(err) if err
        res.locals { removed: req.params.id }
        next()


#### ---------------------------------------------------------------------- ###

module.exports = {
    list
    create
    edit
    destroy
}
