require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }
  it { should have_many :links }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :password_confirmation }

  it { should validate_uniqueness_of :email }

  it { should validate_confirmation_of :password }

  it { should respond_to :email }
  it { should respond_to :password }
end
