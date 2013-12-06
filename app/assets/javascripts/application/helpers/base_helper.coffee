window.AHB = Application.Helpers.Base = 

  basePath: (data) ->
    "/#{data.resource}/#{data.id}/notify/#{data.action}"

