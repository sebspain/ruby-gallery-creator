#!/usr/bin/env ruby

require 'yaml'
require 'RMagick'
include Magick

#load config file
config=YAML.load_file "config.yml"

title = config["title"]
in_dir = config["input"]
out_dir = config["output"]
author = config["author"]
thumbs_dir = out_dir + "/" + "thumbs"

#setup directories

Dir::mkdir(out_dir) unless File.exists?(out_dir)
Dir::mkdir(thumbs_dir) unless File.exists?(thumbs_dir)

Dir.glob("#{in_dir}/*.jpg") do |image| #search directory for jpg files
	image_name = File.basename(image)
 	fullsize = ImageList.new("#{image}")
 	fullsize.write("#{out_dir}/#{image_name}")
 	fullsize.change_geometry!('150x150') { |cols, rows, img|
 		thumb = img.resize(cols, rows)
 		thumb.write("#{out_dir}/thumbs/th_#{image_name}")
 	}
 	puts "\<a href=\"#{image_name}\"\>\<img src=\"thumbs/th_#{image_name}\" /\>\</a\>"
 end