module ContactsHelper
  def contacts_heading
    if params[:case].present?
      params[:case].titleize
    else
      'All Contacts'
    end
  end

  def contacts_event
    params[:scope].present? ? params[:scope] : "index"
  end
end