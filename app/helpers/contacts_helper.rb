module ContactsHelper
  def contacts_heading
    if params[:case].present?
      params[:case].titleize
    else
      'All Contacts'
    end
  end

  def contacts_channel
    params[:case].present? ? "#{params[:case]}_contacts" : "contacts"
  end
end