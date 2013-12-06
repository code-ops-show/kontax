class Contact < ActiveRecord::Base
  include PgSearch
  validates :name,  length: { minimum: 3 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  validates :name,  uniqueness: true

  scope :trashed, -> { where(trash: true) }
  scope :not_trashed, -> { where(trash: false) }

  pg_search_scope :search_by_name_or_email,  against: [:name, :email], using: { tsearch: {prefix: true}}

  def self.search(query)
    query.present? ? search_by_name_or_email(query) : all 
  end

  def status
    self.trash ? 'trashed' : 'alive'
  end

  def move_to_trash
    self.trash = true
    self.save
  end
end
