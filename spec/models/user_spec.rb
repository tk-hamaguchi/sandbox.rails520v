require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.build :user }

  it { is_expected.to belong_to(:tenant) }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_length_of(:name).is_at_least(1).is_at_most(40) }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_length_of(:email).is_at_most(100) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
end
