class Application.Presenters.ContactPresenter extends Transponder.Presenter
  presenterName: 'contacts'
  module: 'application'

  index: ->
    $(@element).hide()
    $(@element).html(@response)
    $(@element).fadeIn(500)