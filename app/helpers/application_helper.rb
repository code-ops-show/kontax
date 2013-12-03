module ApplicationHelper
  def activeable_nav(text, path)
    active = request.path == path ? 'active' : 'inactive'
    content_tag :li, class: active do 
      link_to text, path
    end
  end
end
