# frozen-string-literal: true

#
class MaterialSourceXMLFetchingService
  def initialize(url)
    @url = url
  end

  # Returns merged data of supplier_information and media_information.
  def content
    return if response.status > 200
    supplier_information.merge!(media_information)
  rescue
    return
  end

  private

  # Loads YAML file with configuration of material sources
  def sources_config
    @_sources_config ||= YAML.load_file(Rails.root.join('config/sources_config.yml'))
  end

  def response
    connection = Faraday.new(@url, request: { open_timeout: 2, timeout: 5 })
    @_response ||= connection.get
  end

  def response_body
    @_response_body ||= Hash.from_xml(response.body)
  end

  def supplier_information
    parse_information('supplier_path', 'supplier_keys')
  end

  def media_information
    parse_information('media_path', 'media_keys')
  end

  # The parse_information is for parsing data from sources_config,
  #   and locates nodes in the XML from response_body by +path+ and +keys+ varibables.
  def parse_information(path, keys)
    sources_config.map do |configuration|
      node = response_body.dig(*configuration[path])
      next if node.blank?
      node.slice(*configuration[keys])
    end.compact[0]
  end
end
