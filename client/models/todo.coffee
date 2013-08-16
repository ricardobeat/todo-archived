
App.Model.TodoItem = Backbone.Model.extend {
    urlRoot: '/todos'
    idAttribute: '_id'
    defaults: ->
        return {
            title     : 'todo...'
            completed : false
            priority  : 'normal'
            created   : Date.now()
        }
}

App.Collection.TodoList = Backbone.Collection.extend {
    url: '/todos'
    model: App.Model.TodoItem
    comparator: 'priority'
}
