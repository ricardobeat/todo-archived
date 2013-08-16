describe 'Server', ->

    it 'serves index page at root', (done) ->
        api.get('/')
            .expect(200)
            .expect('Content-Type', /html/)
            .end(done)
