require 'fileutils'
require "pry"

PAK0_FILENAMES = File.readlines("pak0.txt", chomp: true)
PAK1_FILENAMES = File.readlines("pak1.txt", chomp: true)
# TF_PAK0_FILENAMES = File.readlines("pak1.txt", chomp: true)

DEST_PATH = "/tmp/pk3_builder"

Dir.glob(["maps", "*.ent"].join("/")) do |filename|
  map_name = File.basename(filename, File.extname(filename))
  map_path = [DEST_PATH, map_name].join("/")

  puts map_name

  FileUtils.mkdir_p([map_path, "maps"].join("/"))
  FileUtils.cp(filename, [map_path, "maps", "#{map_name}.ent"].join("/"))
  FileUtils.cp(filename, [map_path, "maps", "#{map_name}.bsp"].join("/"))

  dependency_filenames = IO.read(filename)
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
