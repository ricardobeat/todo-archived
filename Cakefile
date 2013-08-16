flour = require 'flour'

task 'dev', ->
    flour.minifiers.disable()

task 'build:styles', ->
    bundle [
        'client/styles/pure-min.css'
        'client/styles/base.styl'
    ], 'public/styles/base.css'

task 'build:vendor', ->
    bundle [
        'client/vendor/jquery.js'
        'client/vendor/underscore.js'
        'client/vendor/backbone.js'
        'client/vendor/handlebars.js'
    ], 'public/scripts/vendor.js'

task 'build:coffee', ->
    bundle [
        'client/app.coffee'
        'client/models/*'
        'client/views/*'
    ], 'public/scripts/app.js'

task 'build', ->
    invoke 'build:vendor'
    invoke 'build:coffee'
    invoke 'build:styles'

task 'watch', ->
    invoke 'build'
    watch 'client/styles/*', -> invoke 'build:styles'
    watch 'client/vendor/*', -> invoke 'build:vendor'
    watch 'client/**/*.coffee', -> invoke 'build:coffee'
