class Application.Presenters.ContactPresenter extends Transponder.Presenter
  presenterName: 'contacts'
  module: 'application'
  actions: ['index', 'edit', 'new', 'create', 'update', 'destroy', 'untrash']

  index: ->
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
    toastr.info("Moved to Trash <a href='/contacts/case/trashed'>View Trashed Contacts</a>")

  untrash: ->
    # remove from the trash page
    @destroy()
    toastr.info("Your contact has been put back <a href='/contacts'>View All Contacts</a>")

  error: 
    update: (errors, element) ->
      for key, value of errors
        $("input#contact_#{key}").tooltip
          title: value[0]
        $("input#contact_#{key}").tooltip('show')

    create: (errors, element) ->
      @update(errors, element)