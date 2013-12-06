module ApplicationHelper
  def activeable_nav(text, path)
    active = request.path == path ? 'active' : 'inactive'
    content_tag :li, class: active do 
      link_to text, path
    end
  end

  def render_collection_with type, collection
    if collection.present?
      render partial: type, collection: collection
    else
      render "#{type.pluralize}/none"
    end
  end

  def render_sub_nav
    request.path.match(/(contacts)/) { |m| render "application/sub_nav/" + m.to_s }
  end
end
