class Application.Services.ContactsSearch extends Transponder.Service
  serviceName: 'contacts_search'
  module: 'application'

  init: ->
    search_field     = @element.find('#search-field')
    search_field.on 'keyup', @submitSearch

  search: _.debounce (=> 
    $.ajax 
      url: $('#search-field').parent().prop('action')
      dataType: 'script'
      data: 
        query: $('#search-field').val()
  ), 600

  submitSearch: =>
    @search()

  serve: ->
    @init()
    # add your code here