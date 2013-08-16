
App = {
    View       : {}
    Model      : {}
    Collection : {}
}

Handlebars.registerHelper 'select', (value, options) ->
    select = document.createElement 'select'
    select.innerHTML = options.fn(this)
    select.value = value
    select.children[select.selectedIndex]?.setAttribute('selected', 'selected')
    return select.innerHTML

AppRouter = Backbone.Router.extend {
    routes:
        'login'    : 'login'
        'register' : 'register'
        'app'      : 'main'

    swapView: (View) ->
        App.currentView?.remove()
        view = new View
        view.render()
        App.currentView = view

    login: ->
        @swapView App.View.Login

    register: ->
        @swapView App.View.Register

    main: ->
        $.get '/todos', (res, status) =>
            App.todos.add res.items if res.items.length > 0
            @swapView App.View.Main
        
}

App.init = ->
    @main = $('#main')
    @todos = new App.Collection.TodoList
    @router = new AppRouter

    Backbone.history.start { pushState: off }
    Backbone.history.navigate 'login', true unless App.user?
    

window.App = App
