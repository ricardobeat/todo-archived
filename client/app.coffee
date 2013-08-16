
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

App.init = ->
    @todos = new App.Collection.TodoList
    @main  = new App.View.Main
    @main.render()

window.App = App
