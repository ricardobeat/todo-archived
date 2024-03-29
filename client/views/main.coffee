
App.View.Main = Backbone.View.extend {
    el: '#main'
    template: Handlebars.compile $('#main-template').html()

    events:
        "keypress #add-todo": "keypressAdd"

    keypressAdd: (e) ->
        return if e.which isnt 13
        input = $(e.target)
        item = new App.Model.TodoItem { title: input.val() }
        item.save()
        console.log item
        App.todos.push item
        input.val('')

    initialize: ->
        this.$el.html @template(@model?.toJSON())
        
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
