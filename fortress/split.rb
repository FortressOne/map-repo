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
  dest_maps_dir = [map_path, "maps"].join("/")
  FileUtils.mkdir_p(dest_maps_dir)
  FileUtils.cp(ent_file, dest_maps_dir)
  FileUtils.cp("maps/#{map_name}.bsp", dest_maps_dir)
  rtlights_file = "maps/#{map_name}.rtlights"
  FileUtils.cp(rtlights_file, dest_maps_dir) if File.file?(rtlights_file)

  # locs/
  loc_file = "locs/#{map_name}.loc"

  if File.file?(loc_file)
    dest_locs_dir = [map_path, "locs"].join("/")
    FileUtils.mkdir_p(dest_locs_dir)
    FileUtils.cp(loc_file, dest_locs_dir)
  end

  # lits/
  lit_file = "lits/#{map_name}.lit"

  if File.file?(lit_file)
    dest_lits_dir = [map_path, "lits"].join("/")
    FileUtils.mkdir_p(dest_lits_dir)
    FileUtils.cp(lit_file, dest_lits_dir)
  end

  # textures/
  src_textures_dir = "textures/#{map_name}/"
  src_levelshots_dir = "textures/levelshots/"

  if File.directory?(src_textures_dir) || File.directory?(src_levelshots_dir)
    dest_textures_dir = [map_path, "textures"].join("/")
    FileUtils.mkdir_p(dest_textures_dir)
  end

  # textures/<map>
  if File.directory?(src_textures_dir)
    FileUtils.copy_entry(src_textures_dir, "#{dest_textures_dir}/#{map_name}")
  end

  # textures/levelshots
  if File.directory?(src_levelshots_dir)
    FileUtils.copy_entry(src_levelshots_dir, "#{dest_textures_dir}/levelshots")
  end

  # files referenced in bsp
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
