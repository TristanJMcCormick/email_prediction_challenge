class EmailObject
  #These are like objc properties
  #give setter/getters for instance variables
  attr_accessor :name, :first_name, :last_name, :first_local_part, :last_local_part, :domain
  def initialize(name, email)
    @name = name
    determine_name_parts(name)
    determine_email_parts(email)
    determine_email_format
  end
  #Breaks out the given name (key in the provided hash)
  #into first and last, to be compared to email parts
  def determine_name_parts(name)
    @first_name = name[0..name.index(" ")].strip.downcase;
    @last_name = name[name.index(" ")..name.length].strip.downcase;
  end
  #Breaks out email parts similarly
  #to be compared to first and last names above
  def determine_email_parts(email)
    @first_local_part = email[0..email.index(".") - 1].strip.downcase;
    @last_local_part = email[email.index(".") + 1..email.index("@") - 1].strip.downcase;
    @domain = email[email.index("@") + 1..email.length].strip.downcase;
  end
  #Four checks, one for each of the possible email formats
  #Should be pretty extensible to other formats, but an enumeration seemed
  #like overkill
  def determine_email_format
    if @first_name == @first_local_part && @last_name == @last_local_part
      @email_form = "first_initial_dot_last_initial"
    elsif @first_name[0] == @first_local_part && @last_name[0] == @last_local_part
      @email_form = "first_initial_dot_last_initial"
    elsif @first_name[0] == @first_local_part && @last_name == @last_local_part
      @email_form = "first_initial_dot_last_name"
    elsif @first_name == @first_local_part && @last_name[0] == @last_local_part
      @email_form = "first_name_dot_last_initial"
    else
      @email_form = "unclear"
    end
  end
end
