require 'rails_helper'

RSpec.describe Screenshotreq, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :name }
    it { is_expected.to have_db_column :urls }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :name}
    it { is_expected.to validate_presence_of :urls}
  end

  describe 'Factory' do
    it 'should have valid factory' do
      expect(FactoryBot.create(:screenshotreq)).to be_valid
    end
  end
end
