
describe 'Todos', ->

    it 'should retrieve a list of todos', (done) ->
        api.get('/todos')
            .expect(200)
            .expect('Content-Type', /json/)
            .end (err, res) ->
                return done(err) if err
                res.body.should.have.property 'items'

    previous = null # shared

    it 'should create a new todo item', (done) ->
        api.post('/todos')
            .set('Content-Type', 'application/json')
            .send({ title: 'test todo' })
            .expect(201)
            .expect('Content-Type', /json/)
            .end (err, res) ->
                return done(err) if err
                res.body.should.have.property 'title', 'test todo'
                res.body.should.have.property 'created'
                res.body.should.have.property 'done', false
                res.body.should.have.property 'priority', 'normal'
                res.body.should.have.property '_id'
                previous = res.body

    it 'should be able to edit an item', (done) ->
        api.put('/todos/' + previous._id)
            .set('Content-Type', 'application/json')
            .send({ title: 'test todo modified' })
            .expect(200)
            .expect('Content-Type', /json/)
            .end (err, res) ->
                return done(err) if err
                res.body.should.have.property 'title', 'test todo modified'
                res.body.should.have.property 'created', previous.created
                res.body.should.have.property 'done', previous.done
                res.body.should.have.property 'priority', previous.priority
                res.body.should.have.property '_id', previous._id

    it 'should be able to delete an item', (done) ->
        api.del('/todos/' + previous._id)
            .expect(200)
            .expect('Content-Type', /json/)
            .end(done)
