#Takes two hashes, one of name-emails (sample dataset) and another of
#name-company pairs
#parse the first array into first name, last name, local part and domain
#Calculate email format
#Inserts company name:email format pairs into dictionary--
#--Where the email format is one of the four offered
#--record error if conflicting formats present in sample
#Take second array of names and companies
#If company is in dictionary, calculate possible email--
#--according to associated pattern
#If not, record error.

$LOAD_PATH << '.'
require 'Email_Prediction_Module.rb'
require 'pry'

#Incoming hash with name-email pairs to base the company email formats on
sample_dataset_hash = {
  "John Ferguson" => "john.ferguson@alphasights.com",
  "Damon Aw" => "damon.aw@alphasights.com",
  "Linda Li" => "linda.li@alphasights.com",
  "Larry Page" => "larry.p@google.com",
  "Sergey Brin" => "s.brin@google.com",
  "Steve Jobs" => "s.j@apple.com"
}
#Hash of name-company pairs that need emails predicted.
prediction_dataset_hash = {
  "Peter Wong" => "alphasights.com",
  "Craig Silverstein" => "google.com",
  "Steve Wozniak" => "apple.com",
  "Barack Obama" => "whitehouse.gov",
}


email_predictor = EmailPredictionObject.new(sample_dataset_hash)

email_predictor.predict_email(prediction_dataset_hash)
