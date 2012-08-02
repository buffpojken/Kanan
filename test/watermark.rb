#coding:utf-8
require 'mini_magick'

image = MiniMagick::Image.open(File.join('fixtures', 'files', 'DSC01532.JPG'))

image.combine_options do |image|
  image << "-font /Library/Fonts/Papyrus.ttc -pointsize 130 -size 450x -gravity northwest -stroke '#86358B' -strokewidth 5 -annotate 0x0+20+22 '" + "45°" +"'"
  image << "-font /Library/Fonts/Papyrus.ttc -pointsize 130 -size 450x -gravity northeast -stroke '#86358B' -strokewidth 5 -annotate 0x0+20+22 '" + "#567" +"'"
  image << "-font /Library/Fonts/Papyrus.ttc -pointsize 130 -size 450x -gravity southwest -stroke '#fff' -strokewidth 5 -annotate 0x0+20+22 '" + "12:43:00" +"'"
end

image.write(File.join("test.jpg"))