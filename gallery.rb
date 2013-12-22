#!/usr/bin/env ruby

require 'RMagick'
include Magick

basedir = '.'

Dir.glob("*.jpg") do |image| #search directory for jpg files
	fullsize = ImageList.new("#{image}")
	fullsize.change_geometry!('150x150') { |cols, rows, img|
		thumb = img.resize(cols, rows)
		thumb.write("./thumbs/th_#{image}")
	}
	puts "\<a href=\"#{basedir}/#{image}\"\>\<img src=\"./thumbs/th_#{image}\" /\>\</a\>"
end