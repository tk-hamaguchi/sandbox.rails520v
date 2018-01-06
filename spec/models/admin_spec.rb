require 'rails_helper'

RSpec.describe Admin, type: :model do
  subject { FactoryBot.build :admin }

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_length_of(:email).is_at_most(100) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
end
