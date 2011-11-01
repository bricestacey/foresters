require 'spec_helper'

describe Name do
  describe "attributes" do
    it { should have_valid(:last).when(nil, '', 'Stacey') }
    it { should have_valid(:first).when(nil, '', 'Brice') }
    it { should have_valid(:middle).when(nil, '', 'M') }
    it { should have_valid(:title).when(nil, '', 'Mr.') }

    it { should have_valid(:record).when(Factory.create(:record)) }
  end
end
