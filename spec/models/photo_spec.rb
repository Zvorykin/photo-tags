require 'rails_helper'
require 'spec_helper'

RSpec.describe Photo, type: :model do

  describe 'validations' do
    let(:photo) { Photo.new( name: 'some name' ) }

    # it 'validates presence of name' do
    #   expect(photo.valid?).to be false
    # end

    it 'validates subject' do
      expect(photo.valid?).to be true
    end
  end
end
