
App.View.TodoItem = Backbone.View.extend {
    tagName: 'li'
    className: 'todo-item'
    template: Handlebars.compile $('#todo-item-template').html()
    initialize: ->

    events:
        "click .delete": "delete"
        "click .edit": "edit"
        "keypress p": "stopEditing"

    delete: ->
        @remove()

    edit: ->
        this.$('p').attr('contenteditable', true).focus()

    stopEditing: (e) ->
        return if e.which isnt 13
        e.preventDefault()
        this.$('p').attr('contenteditable', false).blur()

    render: ->
        this.$el.html @template(@model?.toJSON())
        return this
}
