module FileHelper
  def clean_up(path)
    generated_files = Dir.entries(path).reject! {|entry| entry == "." or entry == ".."}
    generated_files.each do |f|
      FileUtils.rm("#{path}/#{f}")
    end
  end
end
