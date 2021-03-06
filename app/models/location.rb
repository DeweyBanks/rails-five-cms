class Location < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def address
    [street, city, zip, state, 'US'].compact.join(', ')
  end

  def address_changed?
    street_changed? || city_changed? || zip_changed? || state_changed?
  end

end
