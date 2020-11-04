class Location < ApplicationRecord
  # geocoded_by :address
  belongs_to :group_event
  # after_validation :geocode
  
  
  def address
    [state, city, street, zipcode].compact.join ', '
  end
end
