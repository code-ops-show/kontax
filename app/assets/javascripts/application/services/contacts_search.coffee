class Application.Services.ContactsSearch extends Transponder.Service
  serviceName: 'contacts_search'
  module: 'application'

  init: ->
    @element.on 'keyup', "#search-field", @submitSearch

  search: _.debounce ( (e) -> 
    field = @element.find('#search-field')
    $.ajax 
      url: @element.prop('action')
      dataType: 'script'
      data: 
        query: field.val()
  ), 600

  submitSearch: (field) =>
    @search(field)

  serve: ->
    @init()