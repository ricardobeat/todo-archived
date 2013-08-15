var cs = require('coffee-script')
  , server = require('./server')

const PORT = 3008

server.listen(3008)
console.log("Express server listening on port %d", PORT)


