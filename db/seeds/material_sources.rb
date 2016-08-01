[
  { url: ENV[XML_1] },
  { url: ENV[XML_2] }
].each do |material_source|
  ms = MaterialSource.where(url: material_source[:url]).first_or_initialize(url: material_source[:url])
  ms.set_content
  ms.save
end
