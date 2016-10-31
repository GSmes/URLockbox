require 'rails_helper'

RSpec.describe Link, type: :model do
  it { should belong_to :user }

  it { should validate_presence_of :title }
  it { should validate_presence_of :url }

  it { should respond_to :title }
  it { should respond_to :url }
  it { should respond_to :read }

  it "should accept a valid URL" do
    link = build(:link)

    expect(link).to be_valid
  end

  it "should reject an invalid URL" do
    link_1 = build(:link, url: "www.notvalid.com")
    link_2 = build(:link, url: "InvalidString")
    link_3 = build(:link, url: "")

    [link_1, link_2, link_3].each { |link| expect(link).to be_invalid }
  end
end
