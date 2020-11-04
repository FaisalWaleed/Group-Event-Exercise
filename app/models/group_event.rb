class GroupEvent < ApplicationRecord

  belongs_to :user
  has_rich_text :description
  has_one :location, :dependent => :destroy

  accepts_nested_attributes_for :location, allow_destroy: true
  validates :name, presence: true

  default_scope { where(deleted_at: nil).where("ended_at < ?", Time.now) }

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
      ended_at: ended_at,
      duration: duration
    }
  end
  def duration
    unless ended_at.present? && started_at.present?
      return 0
    end
    (ended_at - started_at).to_i
  end
  
  def publish_able?
    name.present? &&
    location&.state.present? &&
    location&.street.present? &&
    location&.city.present? &&
    location&.zipcode.present? &&
    description.present? &&
    started_at.present? &&
    ended_at.present? &&
    secret.present?
  end

end
