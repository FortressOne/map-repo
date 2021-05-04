require 'fileutils'
require "pry"

PAK0_FILENAMES = File.readlines("pak0.txt", chomp: true)
PAK1_FILENAMES = File.readlines("pak1.txt", chomp: true)
TF_PAK0_FILENAMES = File.readlines("tf28_pak0.txt", chomp: true)

DEST_PATH = "/tmp/pk3_builder"

Dir.glob(["maps", "*.ent"].join("/")) do |filename|
  map_name = File.basename(filename, File.extname(filename))

  puts map_name

  FileUtils.mkdir_p([DEST_PATH, map_name, "maps"].join("/"))
  FileUtils.cp(filename, [DEST_PATH, map_name, "maps", "#{map_name}.ent"].join("/"))
  FileUtils.cp(filename, [DEST_PATH, map_name, "maps", "#{map_name}.bsp"].join("/"))

  dependency_filenames = IO.read(filename)
    .encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
    .scan(/\w[\w\/]*\.(?:mdl|bsp|wav)/)

  if dependency_filenames
    dependency_filenames.flatten.uniq.each do |src_file|

      src_file = if File.extname(src_file).delete(".") == "wav"
                   "sounds/#{src_file}"
                 else
                   src_file
                 end

      dest_dir = [DEST_PATH, map_name].join("/")
      FileUtils.mkdir_p(dest_dir)

      dest_path = [dest_dir, src_file].join("/")

      if File.file?(src_file)
        puts "Copying: #{src_file} to #{dest_path}"

        FileUtils.cp(src_file, dest_path)
      else
        puts "Missing! #{src_file} to #{dest_path}"

        File.open([DEST_PATH, map_name, "missing.txt"].join("/"), "a") do |f|
          f.puts src_file
        end
      end
    end
  end
end
