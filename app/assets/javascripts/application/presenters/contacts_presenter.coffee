class Application.Presenters.ContactPresenter extends Transponder.Presenter
  presenterName: 'contacts'
  module: 'application'

  index: ->
    $(@element).html(@response)

  edit: ->
    $(@element).html(@response)
    $(@element).modal()

  update: ->
    $(@element).replaceWith(@response)
    $('#modal-box').modal('toggle')

  error: 
    update: (errors, element) ->
      for key, value of errors
        $("input#contact_#{key}").tooltip
          title: value[0]
        $("input#contact_#{key}").tooltip('show')