require.config(
  shim:
    underscore:
      exports: '_'
    backbone:
      deps: ['underscore', 'jquery']
      exports: 'Backbone'
    epoxy:
      deps: ['underscore', 'jquery', 'backbone']
      exports: 'Epoxy'
  paths:
    jquery: '../../bower_components/jquery/dist/jquery'
    underscore: '../../bower_components/underscore/underscore'
    backbone: '../../bower_components/backbone/backbone'
    epoxy: '../../bower_components/backbone.epoxy/backbone.epoxy'
    inputmask: '../../bower_components/jquery.inputmask/dist/jquery.inputmask.bundle'
)

require(
  ['backbone', 'views/appView']
  (Backbone, AppView) ->
    new AppView()
)
