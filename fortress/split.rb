require 'fileutils'
require "pry"

PAK0_FILENAMES = File.readlines("pak0.txt", chomp: true)
PAK1_FILENAMES = File.readlines("pak1.txt", chomp: true)
# TF_PAK0_FILENAMES = File.readlines("pak1.txt", chomp: true)

DEST_PATH = "/tmp/pk3_builder"

Dir.glob(["maps", "*.ent"].join("/")) do |ent_file|
  map_name = File.basename(ent_file, File.extname(ent_file))
  map_path = [DEST_PATH, map_name].join("/")

  puts map_name

  # maps/
  maps_dir = [map_path, "maps"].join("/")
  FileUtils.mkdir_p(maps_dir)
  FileUtils.cp(ent_file, maps_dir)
  FileUtils.cp("maps/#{map_name}.bsp", maps_dir)

  # locs/
  locs_dir = [map_path, "locs"].join("/")
  FileUtils.mkdir_p(locs_dir)
  loc_file = "locs/#{map_name}.loc"
  FileUtils.cp(loc_file, locs_dir) if File.file?(loc_file)

  # lits/
  lits_dir = [map_path, "lits"].join("/")
  FileUtils.mkdir_p(lits_dir)
  lit_file = "lits/#{map_name}.lit"
  FileUtils.cp(lit_file, lits_dir) if File.file?(lit_file)

  dependency_filenames = IO.read(ent_file)
    .encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
    .scan(/\w[\w\/]*\.(?:mdl|bsp|wav)/)

  if dependency_filenames
    dependency_filenames.flatten.uniq.each do |src_file|
      extension = File.extname(src_file) 
      basename = File.basename(src_file)

      src_file = "sound/#{src_file}" if extension == ".wav"

      dest_file = [map_path, src_file].join("/")
      dest_dir = File.dirname(dest_file)
      FileUtils.mkdir_p(dest_dir)

      if File.file?(src_file)
        puts "Copying: #{src_file} to #{dest_file}"

        FileUtils.cp(src_file, dest_file)
      else
        puts "Missing! #{src_file} to #{dest_file}"

        File.open([map_path, "missing.txt"].join("/"), "a") do |f|
          f.puts src_file
        end
      end
    end
  end
end
