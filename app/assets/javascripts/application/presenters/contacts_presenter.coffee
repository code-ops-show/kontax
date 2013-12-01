class Application.Presenters.ContactsPresenter extends Transponder.Presenter
  presenterName: 'contacts'
  module: 'application'

  index: ->
    $(@element).html(@response)