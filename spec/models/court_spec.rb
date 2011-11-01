require 'spec_helper'

describe Court do
  describe "attributes" do
    it { should have_valid(:name).when(nil, '', 'Cathedra') }
    it { should have_valid(:street).when(nil, '', '17 Worcester Street') }
    it { should have_valid(:town).when(nil, '', 'Worcester Street') }
    it { should have_valid(:instituted_on).when(nil, Date.today) }
    it { should have_valid(:gender).when(nil, 'Men', 'Women', 'Mixed') }
    it { should have_valid(:closed_on).when(nil, '', '1990') }
    it { should have_valid(:notes).when(nil, '', 'foo') }
    it { should have_valid(:created_at).when(Date.today) }
    it { should have_valid(:updated_at).when(Date.today) }

    context 'required for thinking sphinx' do
      it { should have_valid(:delta).when(false, true) }
    end
  end

  describe "associations" do
    it { should have_valid(:ethnicities).when([], [Factory.create(:ethnicity)]) }
    it { should have_valid(:records).when([], [Factory.create(:record)]) }
  end

  it "must define to_s" do
    court = Factory.create(:court, name: 'Sherwood')
    court.to_s.should include('Sherwood')
  end

  describe "#destroy" do
    before(:each) { @court = Factory.create(:court) }

    context 'given it has no records' do
      it "should be successful" do
        @court.destroy.should eq(@court)
      end
      it "should actually be deleted from the database" do
        expect {@court.destroy}.to change(Court, :count).by (-1)
      end
    end
    context 'given it has existing records' do
      before(:each) { @court.records << Factory.create(:record) }

      it "should return false" do
        @court.destroy.should eq(false)
      end
      it "should not be deleted from the database" do
        expect {@court.destroy}.not_to change(Court, :count)
      end
    end
  end
end
