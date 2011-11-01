require 'spec_helper'

describe Record do
  describe "attributes" do
    it { should have_valid(:names).when([], [Factory.create(:name)]) }
    it { should have_valid(:age_at_initiation).when(nil, '', 24) }
    it { should have_valid(:initiated_on_year).when(nil, '2009') }
    it { should have_valid(:initiated_on_month).when(nil, '12') }
    it { should have_valid(:initiated_on_date).when(nil, '1') }
    it { should have_valid(:died_on_year).when(nil, '2009') }
    it { should have_valid(:died_on_month).when(nil, '12') }
    it { should have_valid(:died_on_date).when(nil, '1') }
    it { should have_valid(:age_at_initiation).when(nil, '', 24) }
    it { should have_valid(:suspended_on_year).when(nil, '2009') }
    it { should have_valid(:suspended_on_month).when(nil, '12') }
    it { should have_valid(:suspended_on_date).when(nil, '1') }
    it { should have_valid(:reinstated_on_year).when(nil, '2009') }
    it { should have_valid(:reinstated_on_month).when(nil, '12') }
    it { should have_valid(:reinstated_on_date).when(nil, '1') }
    it { should have_valid(:withdrawn_on_year).when(nil, '2009') }
    it { should have_valid(:withdrawn_on_month).when(nil, '12') }
    it { should have_valid(:withdrawn_on_date).when(nil, '1') }
    it { should have_valid(:transferred_on_year).when(nil, '2009') }
    it { should have_valid(:transferred_on_month).when(nil, '12') }
    it { should have_valid(:transferred_on_date).when(nil, '1') }
    it { should have_valid(:paid_on_year).when(nil, '2009') }
    it { should have_valid(:paid_on_month).when(nil, '12') }
    it { should have_valid(:paid_on_date).when(nil, '1') }
    it { should have_valid(:birth_city).when(nil, '', 'Boston') }
    it { should have_valid(:birth_county).when(nil, '', 'Suffolk') }
    it { should have_valid(:birth_state).when(nil, '', 'Massachusetts') }
    it { should have_valid(:birth_country).when(nil, '', 'USA') }
    it { should have_valid(:notes).when(nil, '', 'foo bar') }

    it { should have_valid(:court).when(nil, Factory.create(:court)) }
    # transferred is a has many relation
    # beneficiary is a has many relation
  end
  describe "#name_last, #name_middle, #name_first, #name_title" do
    before(:each) { @record = Factory.create(:record) }

    context 'given the record does not have a name' do
      it 'returns an empty string' do
        @record.name_last.should eq('')
        @record.name_middle.should eq('')
        @record.name_first.should eq('')
        @record.name_title.should eq('')
      end
    end

    context 'given the record has a single name' do
      before(:each) do
        @name = Factory.create(:name)
        @record.names << @name
      end

      it 'returns that name' do
        @record.name_last.should eq(@name.last)
        @record.name_middle.should eq(@name.middle)
        @record.name_first.should eq(@name.first)
        @record.name_title.should eq(@name.title)
      end
    end

    context 'given the record has multiple names' do
      before(:each) do
        @names = FactoryGirl.create_list(:name, 3)
        @record.names = @names
      end

      it "returns the last name" do
        @record.name_last.should eq(@names.last.last)
        @record.name_middle.should eq(@names.last.middle)
        @record.name_first.should eq(@names.last.first)
        @record.name_title.should eq(@names.last.title)
      end
    end
  end
end
