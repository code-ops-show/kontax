window.AHP = Application.Helpers.Pusher = new Pusher(gon.pusher.key, { encrypted: true })
window.AHB = Application.Helpers.Base = 

  basePath: (data) ->
    "/#{data.resource}/#{data.id}/notify/#{data.action}"

