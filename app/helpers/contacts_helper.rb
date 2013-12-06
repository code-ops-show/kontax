module ContactsHelper
  def contacts_heading
    if params[:case].present?
      params[:case].titleize
    else
      'All Contacts'
    end
  end
end