require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the HomeHelper. For example:
#
# describe HomeHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe HomeHelper, type: :helper do
  context '#resource_name' do
    subject { helper.resource_name }
    it { is_expected.to eq :user }
  end

  context '#resource_class' do
    subject { helper.resource_class }
    it { is_expected.to eq User }
  end

  context '#resource' do
    subject { helper.resource }
    let(:user) { double(User) }
    before do
      allow(User).to receive(:new).and_return(user)
    end
    it { is_expected.to eq user }
    context 'then @resource' do
      before do
        helper.resource
      end
      subject { helper.instance_variable_get :@resource }
      it { is_expected.to eq user }
    end
  end

  context '#devise_mapping' do
    let(:mapper) { double }
    before do
      allow(Devise).to receive(:mappings).and_return(double(Hash, '[]' => mapper))
    end
    subject { helper.devise_mapping }
    it { is_expected.to eq mapper }
    context 'then @devise_mapping' do
      before do
        helper.devise_mapping
      end
      subject { helper.instance_variable_get :@devise_mapping }
      it { is_expected.to eq mapper }
    end
  end
end
