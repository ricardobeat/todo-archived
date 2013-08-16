
App.View.Login = Backbone.View.extend {
    template: Handlebars.compile $('#login-template').html()

    events:
        "click button": "loginAttempt"

    loginAttempt: (e) ->
        e.preventDefault()
        req = $.post '/login', {
            username: @$el.find('#username').val()
            password: @$el.find('#password').val()
        }
        req.done =>
            App.user = true
            Backbone.history.navigate 'app', true
        req.fail =>
            alert 'Invalid credentials'
            @$el.find('input').val('').eq(0).focus()

    initialize: ->

    render: ->
        this.$el.html @template(@model?.toJSON())
        App.main.append @el

}

App.View.Register = Backbone.View.extend {
    template: Handlebars.compile $('#register-template').html()

    events:
        "submit": "register"

    register: (e) ->
        e.preventDefault()
        req = $.post '/user', {
            username: @$el.find('#username').val()
            password: @$el.find('#password').val()
        }
        req.done =>
            App.user = true
            Backbone.history.navigate 'app', true
        req.fail =>
            alert 'Error registering'

    initialize: ->

    render: ->
        this.$el.html @template(@model?.toJSON())
        App.main.append @el

}
