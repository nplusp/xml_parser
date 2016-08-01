# == Schema Information
#
# Table name: material_sources
#
#  id            :integer          not null, primary key
#  url           :string           not null
#  supplier_name :string
#  title         :string
#  episode       :string
#  year          :string
#  duration      :string
#  aspect_ratio  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe MaterialSource, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_presence_of(:supplier_name) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:episode) }
    it { is_expected.to validate_presence_of(:year) }
    it { is_expected.to validate_presence_of(:duration) }
    it { is_expected.to validate_presence_of(:aspect_ratio) }
  end

  describe '.creating' do
    context 'when url is invalid' do
      it { expect(build(:invalid_url_material_source)).not_to be_valid }
    end

    context 'when url is unparseable' do
      let(:material_source) {
        source = build(:unparseable_url_material_source)
        source.set_content
        source
      }
      it { expect(material_source.save).to be_falsey }
    end

    context 'when url is valid' do
      let(:material_source) { build(:valid_material_source) }

      before(:each) do
        material_source.set_content
        material_source.save
      end

      it { expect(material_source.supplier_name).to eql("Adstream") }
      it { expect(material_source.title).to eql("Collection 5") }
      it { expect(material_source.episode).to eql("1") }
      it { expect(material_source.year).to eql("2016") }
      it { expect(material_source.duration).to eql("600") }
      it { expect(material_source.aspect_ratio).to eql("16:9") }
    end
  end

  describe '.audits' do
    let(:material_source) do
      source = build(:valid_material_source)
      VCR.use_cassette('material_source/creating/when_url_is_valid_') do
        source.set_content
      end
      source.save
      source
    end

    it 'audits changes when created' do
      expect(material_source.audits.size).to eql(1)
    end

    it 'audits changes when updated' do
      material_source.title = 'Another title'
      material_source.save
      expect(material_source.audits.size).to eql(2)
    end

    it 'stores audits changes' do
      material_source.title = 'Another title'
      material_source.save
      expect(material_source.changes[-1]).to eql(
        {
          'title' => ['Collection 5', 'Another title'],
          'changed_at' => material_source.audits[-1].created_at
        }
      )
    end
  end
end
