class Application.Services.Notification extends Transponder.Service
  serviceName: 'notification'
  module: 'application'

  init: ->
    channel_name = @element.data('channel')
    event_name   = @element.data('event')

    console.log 
    subscribed_channels = []
    unless jQuery.isEmptyObject(AHP.channels)
      for key, value of AHP.channels.channels
        subscribed_channels.push(key) 

    unless channel_name in subscribed_channels
      channel = AHP.subscribe(channel_name)
    else
      channel = AHP.channel(channel_name)
      
    channel.bind 'pusher:subscription_succeeded', =>
      channel.bind event_name, (data) =>
        @getDelta(data) unless data.who == gon.who


    
  getDelta: (data) ->
    $.ajax
      url: AHB.basePath(data) # this is using the helper
      dataType: 'script'

  serve: ->
    @init()
    # add your code here