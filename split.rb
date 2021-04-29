require "pry"

Dir.glob("fortress/maps/*.ent") do |filename|
  str = IO.read(filename).encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')

  str.scan(/([a-zA-Z0-9]+\.[a-zA-Z0-9]{3})/)

  binding.pry if filename == "fortress/maps/2fort5r.ent"
end

# iterate through the bsps
#   - extract filenames
