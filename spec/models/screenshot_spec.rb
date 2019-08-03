require 'rails_helper'

RSpec.describe Screenshot, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :url }
    it { is_expected.to have_db_column :img_path }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :url}
    it { is_expected.to validate_presence_of :img_path}
  end

  describe 'Factory' do
    it 'should have valid factory' do
      expect(FactoryBot.create(:screenshot)).to be_valid
    end
  end
end
