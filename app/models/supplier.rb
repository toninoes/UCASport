class Supplier < ActiveRecord::Base
  has_and_belongs_to_many :articles
  validates_presence_of :first_name, :last_name
  validates_length_of :first_name, :in => 2..255
  validates_length_of :last_name, :in => 2..255

  def name
    "#{first_name} #{last_name}"
  end
end
