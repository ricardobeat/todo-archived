
request  = require 'supertest'
should   = require 'should'

process.env.MONGO_URL = "mongodb://localhost/topdo-test"

app = require '../server'

global.api = request(app)
global.api.cookies = null

after (done) ->
    mongoose = require 'mongoose'
    mongoose.model('User').remove({}).exec(done)
    mongoose.model('Todo').remove({}).exec(done)
