class Contact < ActiveRecord::Base
  include PgSearch
  validates :name,  length: { minimum: 3 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  pg_search_scope :search_by_name_or_email,  against: [:name, :email], using: { tsearch: {prefix: true}}

  def self.search(query)
    query.present? ? search_by_name_or_email(query) : all 
  end
end
