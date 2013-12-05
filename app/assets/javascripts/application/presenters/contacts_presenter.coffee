class Application.Presenters.ContactPresenter extends Transponder.Presenter
  presenterName: 'contacts'
  module: 'application'

  index: ->
    console.log @element
    $(@element).html(@response)

  edit: ->
    $(@element).html(@response)
    $(@element).modal()

  new: ->
    @edit()

  create: ->
    $(@element).append(@response)
    $("#modal-box").modal('toggle')

  update: ->
    $(@element).replaceWith(@response)
    $('#modal-box').modal('toggle')

  destroy: ->
    $(@element).fadeOut 500, ->
      $(@element).remove()

  error: 
    update: (errors, element) ->
      for key, value of errors
        $("input#contact_#{key}").tooltip
          title: value[0]
        $("input#contact_#{key}").tooltip('show')

    create: (errors, element) ->
      @update(errors, element)