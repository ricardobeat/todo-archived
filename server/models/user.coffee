mongoose = require 'mongoose'
pwd      = require 'pwd'
_        = require 'underscore'

UserSchema = new mongoose.Schema {
    username : { type: String, unique: true }
    password : { type: String, select: false }
    salt     : { type: String, select: false }
    created  : { type: Date, default: Date.now }
}

# Register a new user. Generates a salt and hashes password using crypto's pbkdf2
UserSchema.static 'register', (username, password, callback) ->
    unless username? and password?
        return callback new Error('Missing fields')

    pwd.hash password, (err, salt, hash) =>
        return callback(err) if err
        @create {
            username : username
            password : hash.toString('base64')
            salt     : salt
        }, callback


# Find by username.
UserSchema.static 'findByUsername', (username, callback) ->
    @findOne { username }, callback


# Verify user credentials.
UserSchema.static 'verify', (username, password, callback) ->
    @findOne({ username}).select('username salt password').exec (err, user) ->
        return callback(err) if err
        pwd.hash password, user?.salt, (err, hash) ->
            return callback(err) if err
            hash = hash.toString('base64')
            if user.password isnt hash
                return callback new Error('Invalid credentials')
            callback null, user.toObjectSafe()


# Return a "safe" version of the user object omitting credentials.
UserSchema.method 'toObjectSafe', () ->
    return _.omit @toObject(), 'password', 'salt'


module.exports = UserSchema
