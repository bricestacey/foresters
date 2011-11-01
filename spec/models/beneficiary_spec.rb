require 'spec_helper'

describe Beneficiary do
  describe 'attributes' do
    it { should have_valid(:relationship).when(nil, '', 'Mother') }
    it { should have_valid(:record).when(Factory.create(:record)) }
    it { should_not have_valid(:record).when(nil) }
    it { should have_valid(:name).when(Factory.create(:name)) }
  end
end
