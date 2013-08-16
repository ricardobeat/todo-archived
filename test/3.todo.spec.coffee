
describe 'Todos', ->

    previous = null

    it 'should create a new todo item', (done) ->
        api.post('/todos')
            .set('Cookie', api.cookies)
            .set('Content-Type', 'application/json')
            .send({ title: 'test todo' })
            .expect(201)
            .expect('Content-Type', /json/)
            .end (err, res) ->
                return done(err) if err
                res.body.should.have.property 'title', 'test todo'
                res.body.should.have.property 'created'
                res.body.should.have.property 'completed', false
                res.body.should.have.property 'priority', 'normal'
                res.body.should.have.property '_id'
                previous = res.body
                done()

    it 'should retrieve a list of todos', (done) ->
        api.get('/todos')
            .set('Cookie', api.cookies)
            .expect(200)
            .expect('Content-Type', /json/)
            .end (err, res) ->
                return done(err) if err
                res.body.should.have.property('items').with.lengthOf 1
                res.body.items[0].should.have.property 'title', 'test todo'
                done()

    it 'should be able to edit an item', (done) ->
        api.put('/todos/' + previous._id)
            .set('Cookie', api.cookies)
            .set('Content-Type', 'application/json')
            .send({ title: 'test todo modified' })
            .expect(200)
            .expect('Content-Type', /json/)
            .end (err, res) ->
                return done(err) if err
                res.body.should.have.property 'title', 'test todo modified'
                res.body.should.have.property 'created', previous.created
                res.body.should.have.property 'completed', previous.done
                res.body.should.have.property 'priority', previous.priority
                res.body.should.have.property '_id', previous._id
                done()

    it 'should be able to delete an item', (done) ->
        api.del('/todos/' + previous._id)
            .set('Cookie', api.cookies)
            .expect(200)
            .expect('Content-Type', /json/)
            .end(done)
