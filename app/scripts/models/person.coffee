define(
  ['underscore', 'backbone']
  (_, Backbone) ->
    Person = Backbone.Model.extend(
      defaults:
        name: ''
        lastName: ''
        phone: ''
        mail: ''
        date: ''
    )
    return Person
)
