
app     = require '../server'
request = require 'supertest'

api = request(app)

describe 'Server', ->

    it 'serves index page at root', (done) ->
        api.get('/')
            .expect(200)
            .expect('Content-Type', /html/)
            .end(done)

describe 'Authentication', ->

    testUser = {
        username: 'test123'
        password: 'abcdef'
    }

    describe 'Registration', ->

        it 'returns an error if insufficient data provided', (done) ->
            api.post('/user')
                .set('Content-Type', 'application/json')
                .send({ username: '' })
                .expect(500)
                .expect('Content-Type', /json/)
                .expect({
                    code: '500'
                    message: 'Missing fields'
                })
                .end(done)

        it 'allows me to register a new user', (done) ->
            api.post('/user')
                .set('Content-Type', 'application/json')
                .send(testUser)
                .expect(201)
                .expect('Content-Type', /json/)
                .expect({
                    username: testUser.username
                })
                .end(done)

    describe 'Login', ->

        it 'fails when given invalid credentials', (done) ->
            api.post('/login')
                .set('Content-Type', 'application/json')
                .send({ username: null, password: null })
                .expect(401)
                .expect('Content-Type', /json/)
                .expect({
                    code: '401'
                    message: 'Invalid credentials'
                })
                .end(done)

        it 'succeeds with a registered user', (done) ->
            api.post('/login')
                .set('Content-Type', 'application/json')
                .send(testUser)
                .expect(200)
                .expect('Content-Type', /json/)
                .expect('Set-Cookie', /connect\.sid/)
                .expect({
                    username: testUser.username
                })
                .end(done)
