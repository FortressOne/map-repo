require 'fileutils'
require "pry"
DEST_PATH = "package"

Dir.glob(["textures", "*"].join("/")) do |src_textures_dir|
  map_name = File.basename(src_textures_dir)
  puts map_name

  dest_textures_dir = "#{DEST_PATH}/#{map_name}/textures"

  FileUtils.mkdir_p(dest_textures_dir)
  FileUtils.copy_entry(src_textures_dir, "#{dest_textures_dir}/#{map_name}")
end
