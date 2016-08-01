require './spec/spec_helper'

describe MaterialSourceXMLFetchingService do
  describe '.content' do
    context 'invalid url' do
      let(:url) { build(:unparseable_url_material_source).url }
      let(:service) { MaterialSourceXMLFetchingService.new(url) }

      it 'returns nothing' do
        expect(service.content).to eql(nil)
      end
    end

    context 'valid url' do
      let(:url) { build(:valid_material_source).url }
      let(:service) { MaterialSourceXMLFetchingService.new(url) }

      it 'returns parsed hash' do
        expect(service.content).to eql(
          {
            "supplierName"=>"Adstream",
            "title"=>"Collection 5",
            "episode"=>"1",
            "year"=>"2016",
            "duration"=>"00:00:10:00",
            "aspectRatio"=>"16:9"
          }
        )
      end
    end
  end
end
