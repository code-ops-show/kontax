class Application.Services.ContactsSearch extends Transponder.Service
  serviceName: 'contacts_search'
  module: 'application'

  init: ->
    @element.hide()
    @element.removeClass('hide')
    @element.fadeIn()
    @element.on 'keyup', "#search-field", @submitSearch

  search: _.debounce (->
    field = @element.find('#search-field')
    $.ajax 
      url: @element.prop('action')
      dataType: 'script'
      data: 
        query: field.val()
      complete: ->
        NProgress.done()
  ), 600

  submitSearch: =>
    NProgress.start()
    @search()

  serve: ->
    @init()