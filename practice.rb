class EmailObject
  attr_accessor
  :name
  :first_name
  :last_name
  :first_local_part
  :last_local_part
  :domain
  def initialize(name, email)
    @name = name
    determine_name_parts(name)
    determine_email_parts(email)
    determine_email_format
  end
  # def inspect
  #   "First Name: " + @first_name +
  #   "Last Name: " + @last_name +
  #   "First Local Part: " + @first_local_part +
  #   "Last Local Part: " + @last_local_part +
  #   "Domain: " + @domain
  # end
  def determine_name_parts(name)
    @first_name = name[0..name.index(" ")].strip;
    @last_name = name[name.index(" ")..name.length].strip;
  end
  def determine_email_parts(email)
    @first_local_part = email[0..email.index(".") - 1].strip;
    @last_local_part = email[email.index(".") + 1..email.index("@") - 1].strip;
    @domain = email[email.index("@") + 1..email.length].strip;
  end
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

tristan = EmailObject.new("Tristan McCormick","Tristan.McCormick@gmail.com");

p tristan
