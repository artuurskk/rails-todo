class Task < ApplicationRecord
  belongs_to :user
  validates :name, :description, presence: true

  def self.search(search)
    where("created_at LIKE ?", "%#{search}%")
  end

end
