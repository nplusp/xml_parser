# frozen-string-literal: true

#
module ContentFetchingHelper
  # Setting attributes from XML to attributes of calling record.
  def set_content
    if xml_content.blank?
      errors.add(:url, I18n.t('material_source.errors.url.unparseble'))
      return false
    end

    assign_attributes(
      supplier_name: xml_content['supplierName'] || xml_content['supplierInfo'],
      title: xml_content['title'],
      episode: xml_content['episode'],
      year: xml_content['year'],
      duration: parsed_duration,
      aspect_ratio: xml_content['aspectRatio']
    )
  end

  private

  # Splits duration string to days, hours, minutes and seconds.
  #   Then calculates them and returns duration in seconds.
  def parsed_duration
    days, hours, minutes, seconds = xml_content['duration'].split(':').map(&:to_i)
    days * 1.day.seconds + hours * 1.hour.seconds + minutes * 1.minute.seconds + seconds
  end

  def xml_content
    xml_service.content
  end

  def xml_service
    @_xml_service ||= MaterialSourceXMLFetchingService.new(url)
  end
end
