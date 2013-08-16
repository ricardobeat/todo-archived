mongoose = require 'mongoose'
_        = require 'underscore'
ObjectId = mongoose.Schema.Types.ObjectId

TodoSchema = new mongoose.Schema {
    title     : { type: String }
    completed : { type: Boolean, default: false }
    priority  : { type: String, enum: ['low', 'normal', 'urgent'], default: 'normal' }
    created   : { type: Date, default: Date.now }
    user      : { type: ObjectId, ref: 'User' }
}

TodoSchema.method 'toObjectSafe', ->
    return _.omit @toObject(), '__v', 'user'

module.exports = TodoSchema
