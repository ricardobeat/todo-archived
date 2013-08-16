
App.View.Main = Backbone.View.extend {
    el: '#main'

    events:
        "keypress #add-todo": "keypressAdd"

    keypressAdd: (e) ->
        return if e.which isnt 13
        input = $(e.target)
        App.todos.push { title: input.val() }
        input.val('')

    initialize: ->
        @newItem = new App.View.NewItem
        @list = @$el.find('.todos')

        @listenTo App.todos, 'add', @add
        @listenTo App.todos, 'reset', @render

    add: (model) ->
        view = new App.View.TodoItem { model }
        @list.append view.render().el

    render: ->
        App.todos.each @add, this

}
