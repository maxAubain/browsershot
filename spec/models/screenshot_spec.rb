require 'rails_helper'

RSpec.describe Screenshot, type: :model do

  describe 'DB table' do
    it { is_expected.to have_db_column :url }
    it { is_expected.to have_db_column :image_file_path }
    it { is_expected.to have_db_column :image_file_name }
    it { is_expected.to have_db_column :screenshotreq_id }
    it { is_expected.to have_db_index :screenshotreq_id }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :url}
    it { is_expected.to validate_presence_of :image_file_path}
    it { is_expected.to validate_presence_of :image_file_name}
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
