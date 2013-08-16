flour = require 'flour'

task 'build:styles', ->
    bundle [
        'client/styles/pure-min.css'
        'client/styles/base.styl'
    ], 'public/styles/base.css'

task 'build', ->
    invoke 'build:styles'

task 'watch', ->
    invoke 'build:styles'
    watch 'client/styles/*', -> invoke 'build:styles'
