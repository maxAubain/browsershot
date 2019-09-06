require 'rails_helper'

RSpec.describe Screenshot, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :url }
    it { is_expected.to have_db_column :img_path }
    it { is_expected.to have_db_column :img_path_short }
    it { is_expected.to have_db_column :screenshotreq_id }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :url}
    it { is_expected.to validate_presence_of :img_path}
    it { is_expected.to validate_presence_of :img_path_short}
  end

  describe 'Factory' do
    it 'should have valid factory' do
      expect(FactoryBot.create(:screenshot)).to be_valid
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to :screenshotreq}
  end
end
