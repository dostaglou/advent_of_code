class FileManager
  attr_accessor :day

  def initialize(day)
    @day = day
  end

  def raw_data(file_name)
    File.readlines(self.path(day, file_name))
  end

  def stripped_data(file_name)
    raw_data(file_name).map { |x| x.gsub("\n", "") }
  end

  private

    def path(day, file_name)
      File.join(File.absolute_path(__dir__), day, file_name)
    end
end


