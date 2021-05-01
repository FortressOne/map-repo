require 'fileutils'
require "pry"

PAK0_FILENAMES = File.readlines("pak0.txt", chomp: true)
PAK1_FILENAMES = File.readlines("pak1.txt", chomp: true)
# TF_PAK0_FILENAMES = File.readlines("pak1.txt", chomp: true)

ASSET_SUBDIRS = {
  "mdl" => nil,
  "bsp" => "progs",
  "wav" => "sound"
}

DEST_PATH = "/tmp/pk3_builder"

Dir.glob(["fortress", "maps", "*.ent"].join("/")) do |filename|
  puts map_name = File.basename(filename, File.extname(filename))

  FileUtils.mkdir_p([DEST_PATH, map_name, "maps"].join("/"))
  FileUtils.cp(filename, [DEST_PATH, map_name, "maps", "#{map_name}.ent"].join("/"))
  FileUtils.cp(filename, [DEST_PATH, map_name, "maps", "#{map_name}.bsp"].join("/"))

  dependency_filenames = IO.read(filename)
    .encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
    .scan(/\w[\w\/]*\.(?:mdl|bsp|wav)/)

  if dependency_filenames
    dependency_filenames.flatten.uniq.each do |dep|
      puts dep
      ext = File.extname(dep).delete(".")
      if ASSET_SUBDIRS[ext]
        subdir = ASSET_SUBDIRS.fetch(ext, "progs")
        source_file = ["fortress", subdir, dep].join("/")
        dest_path = [DEST_PATH, map_name, subdir].join("/")
      else
        subdir = nil
        source_file = ["fortress", dep].join("/")
        dest_path = [DEST_PATH, map_name].join("/")
      end

      FileUtils.mkdir_p(dest_path)

      if File.file?(source_file)
        FileUtils.cp(source_file, dest_path)
      else
        File.open([DEST_PATH, map_name, "missing.txt"].join("/"), "a") do |f|
          f.puts([subdir, dep].compact.join("/"))
        end
      end
    end
  end

  puts
end
