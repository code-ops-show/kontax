class Application.Services.Notification extends Transponder.Service
  serviceName: 'notification'
  module: 'application'

  init: ->
    pusher = new Pusher(gon.pusher.key, { encrypted: true })

    channel_name = @element.data('channel')
    event_name   = @element.data('event')

    channel = pusher.subscribe(channel_name)
    channel.bind event_name, (data) ->
      $.ajax
        url: AHB.basePath(data) # this is using the helper
        dataType: 'script'

  serve: ->
    @init()
    # add your code here