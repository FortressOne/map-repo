require 'fileutils'
require "pry"

PAK0_FILENAMES = File.readlines("pak0.txt", chomp: true)
PAK1_FILENAMES = File.readlines("pak1.txt", chomp: true)
ASSET_SUBDIRS = {
  "mdl" => "progs",
  "bsp" => "progs",
  "loc" => "locs",
  "lit" => "lits",
  "wav" => "sound"
}

IGNORED_DEPS = %w(
Doomtex.wad
progs/soldier.mdl
)

Dir.glob("fortress/maps/*.ent") do |filename|
  ent_file = IO.read(filename).encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
  map_name = File.basename(filename, File.extname(filename))
  FileUtils.mkdir_p("/tmp/pk3_builder/#{map_name}")

  dependency_filenames = ent_file.scan(/([a-zA-Z0-9\/]+\.[a-zA-Z0-9]{3})/).flatten

  dependency_filenames.each do |dep|
    next if IGNORED_DEPS.include?(dep)
    ext = File.extname(dep).delete(".")

    subdir = ASSET_SUBDIRS.fetch(ext, "progs")
    source_file = "fortress/#{subdir}/#{dep}"
    dest_path = "/tmp/pk3_builder/#{map_name}/#{subdir}/"
    FileUtils.mkdir_p(dest_path)

    puts source_file
    puts dest_path
    puts

    if File.file?(source_file)
      FileUtils.cp(source_file, dest_path)
    else
      File.open("/tmp/pk3_builder/#{map_name}/missing.txt", "a") do |f|
        f.puts("#{subdir}/#{dep}")
      end
    end
  end
end
