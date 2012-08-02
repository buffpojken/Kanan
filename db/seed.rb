# Left empty on purpose...        

["1532", "1533", "1534", "1535", "1536", "1537"].each_with_index do |f, i|
   photo = Photo.create({
     :photo          => File.open(File.join('test', 'fixtures', 'files', 'DSC0'+f+".JPG"), 'r'), 
     :temperature   => "35,6", 
     :ride_no       => i, 
     :ride_time     => Time.now
   })
end