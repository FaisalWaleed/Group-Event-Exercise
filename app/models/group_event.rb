class GroupEvent < ApplicationRecord
  default_scope {where(:deleted_at => nil)}
  belongs_to :user
  has_rich_text :description
  has_one :location, :dependent => :destroy
  validates :name, presence: true
  accepts_nested_attributes_for :location, allow_destroy: true
  def to_object
    {
      id: id,
      name: name,
      description: description.body,
      location: {
        state: location&.state,
        city: location&.city,
        street: location&.street,
        zipcode: location&.zipcode
      },
      started_at: started_at,
      ended_at: ended_at
    }
  end
  def publish_able?
    name.present? && location&.state.present? && location&.street.present?  && location&.city.present?  && location&.zipcode.present? && description.present? && started_at.present? && ended_at.present?
  end

end
