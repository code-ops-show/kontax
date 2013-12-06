class Application.Presenters.ContactPresenter extends Transponder.Presenter
  presenterName: 'contacts'
  module: 'application'
  actions: ['index', 'edit', 'new', 'create', 'update', 'destroy', 'untrash', 'show']

  index: ->
    $(@element).html(@response)

  edit: ->
    $(@element).html(@response)
    $(@element).modal()

  show: ->
    $(@element).replaceWith(@response)

  new: ->
    @edit()

  create: ->
    $(@element).append(@response.content)
    $("#modal-box").modal('hide')
    toastr.success(@response.notification)

  update: ->
    $(@element).replaceWith(@response)
    $('#modal-box').modal('hide')
    toastr.success(@response.notification)

  destroy: ->
    $(@element).fadeOut 500, ->
      $(@element).remove()
    toastr.info(@response.notification)

  untrash: ->
    $(@element).fadeOut 500, ->
      $(@element).remove()
    toastr.info(@response.notification)

  error: 
    update: (errors, element) ->
      for key, value of errors
        $("input#contact_#{key}").tooltip
          title: value[0]
        $("input#contact_#{key}").tooltip('show')

    create: (errors, element) ->
      @update(errors, element)