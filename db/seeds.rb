Dir[Rails.root.join('db', 'seeds', '*.rb')].each do |seed_file|
  puts "========== Load #{File.basename(seed_file)}\n"
  load seed_file
  puts "Done."
end
