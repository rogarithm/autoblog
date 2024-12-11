module FileHelper
  def clean_up(path)
    generated_files = Dir.entries(path).select! {|entry| entry.end_with? ".html"}
    generated_files.each do |f|
      FileUtils.rm "#{path}/#{f}"
    end
  end
end
