#Takes two hashes, one of name-emails (sample dataset) and another of
#name-company pairs
#parses the first array into first name, last name, local part and domain
#Calculate email format
#Inserts company name:email format pairs into dictionary--
#--Where the email format is one of the four offered
#Take second array of names and companies
#If company is in dictionary, calculate possible email--
#--according to associated pattern
#If not, generate all four with error message.

$LOAD_PATH << '.'

require 'Email_Object_Module.rb'

sample_dataset = {
  "John Ferguson" => "john.ferguson@alphasights.com",
  "Damon Aw" => "damon.aw@alphasights.com",
  "Linda Li" => "linda.li@alphasights.com",
  "Larry Page" => "larry.p@google.com",
  "Sergey Brin" => "s.brin@google.com",
  "Steve Jobs" => "s.j@apple.com"
}

email_objects_hash = Hash.new(sample_dataset.length)
company_email_format_hash = Hash.new()

sample_dataset.each do |name, email|
  s = EmailObject.new(name,email)
  email_objects_hash[s.name] = s
end


def add_company_email_format(email_object)

end
