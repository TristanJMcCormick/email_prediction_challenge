class EmailObject
  #These are like objc properties
  #give setter/getters for instance variables
  attr_accessor :name,
  :first_name,
  :last_name,
  :first_local_part,
  :last_local_part,
  :domain,
  :email_format,
  :email
  def initialize(name = "no_name", email = "no_email")
    @name = name
    @email_format = "no_email_format"
    @domain = "no_domain"
    if name != "no_name"
      determine_name_parts(name)
    end
    if email != "no_email"
      set_email_parts(email)
    end
  end
end
#Breaks out the given name (key in the provided hash)
#into first and last, to be compared to email parts
def determine_name_parts(name)
  @first_name = name[0..name.index(" ")].strip.downcase
  @last_name = name[name.index(" ")..name.length].strip.downcase
end
#Breaks out email parts similarly
#to be compared to first and last names above
public
def set_email_parts(email)
  if @email.nil?
    @email = email
    @first_local_part = email[0..email.index(".") - 1].strip.downcase
    @last_local_part = email[email.index(".") + 1..email.index("@") - 1].strip.downcase
    @domain = email[email.index("@") + 1..email.length].strip.downcase
  else
    @email = @email + "," + email
    @first_local_part = @first_local_part + "," + email[0..email.index(".") - 1].strip.downcase
    @last_local_part = @last_local_part + "," + email[email.index(".") + 1..email.index("@") - 1].strip.downcase
    @domain = email[email.index("@") + 1..email.length].strip.downcase
  end
end
class EmailPredictionObject
  #Takes two hashes, one of name-emails (sample dataset) and another of
  #name-company pairs (for which we'll estimate the emails)
  #Four checks, one for each of the possible email formats
  #Should be pretty extensible to other formats, but an enum seemed overkill
  def determine_email_format(new_email_object)
    if new_email_object.first_name == new_email_object.first_local_part && new_email_object.last_name == new_email_object.last_local_part
      new_email_object.email_format = "first_name_dot_last_name"
    elsif new_email_object.first_name[0] == new_email_object.first_local_part && new_email_object.last_name[0] == new_email_object.last_local_part
      new_email_object.email_format = "first_initial_dot_last_initial"
    elsif new_email_object.first_name[0] == new_email_object.first_local_part && new_email_object.last_name == new_email_object.last_local_part
      new_email_object.email_format = "first_initial_dot_last_name"
    elsif new_email_object.first_name == new_email_object.first_local_part && new_email_object.last_name[0] == new_email_object.last_local_part
      new_email_object.email_format = "first_name_dot_last_initial"
    else
      new_email_object.email_format = "unclear"
    end
  end
  def add_company_email_format(new_email)
    #if the hash of companies and their email formats is empty,
    #insert the first entry
    if @company_email_format_hash.empty?
      @company_email_format_hash[new_email.domain] = new_email.email_format
    else
      #if the @company_email_format_hash isn't empty, check if the company is already represented,
      #insert an entry if it is not
      if !@company_email_format_hash.key? new_email.domain
        @company_email_format_hash[new_email.domain] = new_email.email_format
        #if it is in the @company_email_format_hash, then check if the values match.
        #If they do we're fine since the email format already in the @company_email_format_hash matches
        #that of the duplicate example.
        #if they don't, replace value with error message
      elsif
        if @company_email_format_hash[new_email.domain] != new_email.email_format
          @company_email_format_hash[new_email.domain] = @company_email_format_hash[new_email.domain] + "," + new_email.email_format
        end
      end
    end
  end
  def initialize(sample_dataset_hash)
    #Where email objects from sample dataset are stored
    @parsed_sample_dataset_hash = Hash.new()
    #Master hash of company-email format pairs
    @company_email_format_hash = Hash.new()
    #Process email data set into parsed_sample_dataset_hash
    sample_dataset_hash.each do |name, email|
      new_email = EmailObject.new(name,email)
      determine_email_format(new_email)
      @parsed_sample_dataset_hash[new_email.name] = new_email
      add_company_email_format(new_email)
    end
  end
  def predict_email(prediction_dataset_hash)
    prediction_dataset_hash.each do |name, domain|
      new_email = EmailObject.new(name)
      if @company_email_format_hash.key? domain
        new_email.email_format = @company_email_format_hash[domain]
        new_email.domain = domain
        puts "Name: #{new_email.name} Domain: #{new_email.domain} Format:#{new_email.email_format}"
        if !new_email.email_format.include? ","
          generate_email_address(new_email,new_email.email_format)
        else
          new_email.email_format.split(",").each do |format|
            generate_email_address(new_email, format)
          end
        end
      else
        puts "We don't have information for that domain"
      end
      puts "Name: #{new_email.name} Domain: #{new_email.domain} Format:#{new_email.email_format} Email:#{new_email.email}"
      puts "\n"
    end
  end
  def generate_email_address(new_email, email_format)
    case
    when email_format == "first_name_dot_last_name"
      new_email_address = new_email.first_name + "." + new_email.last_name + "@" + new_email.domain
      new_email.set_email_parts(new_email_address)
      return new_email_address
    when email_format == "first_initial_dot_last_initial"
      new_email_address = new_email.first_name[0] + "." + new_email.last_name[0] + "@" + new_email.domain
      new_email.set_email_parts(new_email_address)
      return new_email_address
    when email_format == "first_initial_dot_last_name"
      new_email_address = new_email.first_name[0] + "." + new_email.last_name + "@" + new_email.domain
      new_email.set_email_parts(new_email_address)
      return new_email_address
    when email_format == "first_name_dot_last_initial"
      new_email_address = new_email.first_name + "." + new_email.last_name[0] + "@" + new_email.domain
      new_email.set_email_parts(new_email_address)
      return new_email_address
    end
  end
end
