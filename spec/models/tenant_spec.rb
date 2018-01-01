require 'rails_helper'

RSpec.describe Tenant, type: :model do
  subject { FactoryBot.build :tenant }

  it { is_expected.to have_many(:users).dependent(:destroy) }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_length_of(:name).is_at_least(1).is_at_most(40) }
  it { is_expected.to validate_presence_of :status }

  context '#status' do
    context 'default' do
      subject { super().status }
      it { is_expected.to eq 'active' }
    end
  end

  context '#status=' do
    %w[inactive locked active].each do |stat|
      context '"' + stat + '"' do
        context 'then status' do
          subject { super().status = stat ; super().status }
          it { is_expected.to eq stat }
        end
      end
    end
  end
end
