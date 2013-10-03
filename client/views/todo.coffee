
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
        @model.destroy()
        @remove()

    edit: ->
        this.$('p').attr('contenteditable', true).focus()

    stopEditing: (e) ->
        return if e.which isnt 13
        e.preventDefault()
        this.$('p').attr('contenteditable', false).blur()
        @model.set {
            title: this.$('p').text()
            priority: this.$('.priority').val()
        }
        @model.save()

    render: ->
        this.$el.html @template(@model?.toJSON())
        return this
}
