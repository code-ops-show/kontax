class Application.Services.Notification extends Transponder.Service
  serviceName: 'notification'
  module: 'application'

  init: ->
    channel_name = @element.data('channel')
    event_name   = @element.data('event')

    channel = if AHP.channel(channel_name)
                AHP.channel(channel_name)
              else
                AHP.subscribe(channel_name)

    channel.bind event_name, @pusherCallback

    $(document).on 'page:fetch', => 
      channel.unbind event_name, @pusherCallback


  pusherCallback: (data) =>
    @getDelta(data) unless data.who == gon.who
    
  getDelta: (data) ->
    $.ajax
      url: AHB.basePath(data) # this is using the helper
      dataType: 'script'

  serve: ->
    @init()
    # add your code here