require 'rails_helper'

RSpec.describe Location, type: :model do
  subject {
    described_class.new(
                        state: "state",
                        city: "city",
                        street: "street",
                        zipcode: "zipcode",
                        group_event: GroupEvent.create(name: "name",user: User.create(name: "name",email: "email@gmail.com"))
                      )
  }
  it "is not valid without a group_event" do 
    subject.group_event=nil
    expect(subject).to_not be_valid
  end
  it "is valid without a state" do 
    subject.state=nil
    expect(subject).to be_valid
  end
  it "is valid without a city" do 
    subject.city=nil
    expect(subject).to be_valid
  end
  it "is valid without a street" do 
    subject.street=nil
    expect(subject).to be_valid
  end
  it "is valid without a zipcode" do 
    subject.zipcode=nil
    expect(subject).to be_valid
  end
end