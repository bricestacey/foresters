require 'spec_helper'

describe Ethnicity do
  describe 'attributes' do
    it { should have_valid(:name).when('Irish') }
    it { should_not have_valid(:name).when(nil, '') }

    it { should have_valid(:courts).when([], [Factory.create(:court)]) }
  end

  describe "#destroy" do
    before(:each) { @ethnicity = Factory.create(:ethnicity) }

    context 'given the ethnicity has been assigned to a court' do
      before(:each) { @ethnicity.courts << Factory.create(:court) }
      it 'should return false' do
        @ethnicity.destroy.should eq(false)
      end
      it 'should not be deleted from the database' do
        expect { @ethnicity.destroy }.to_not change(Ethnicity, :count)
      end
    end

    context 'given the ethnicity has not been assigned to a court' do
      it 'should be successful' do
        @ethnicity.destroy.should eq(@ethnicity)
      end
      it 'should be deleted from the database' do
        expect { @ethnicity.destroy }.to change(Ethnicity, :count).by(-1)
      end
    end
  end
end
