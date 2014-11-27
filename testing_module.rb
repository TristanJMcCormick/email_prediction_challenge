class Sample_Class
  attr_accessor :hash
  @hash = Hash.new
  def initialize
    puts @hash
    @hash["tristan"] = "boobs"
    puts @hash
  end
end
