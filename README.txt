Hello! This is a document detailing the functions of the Email Prediction application contained 
in this directory which comprises the Tristan_McCormick_Alphasights_exercise.rb and Email_Prediction_Module.rb files.

This was completed in response to the prompt found at the _____________ gist as part of the application for the position
of software engineer at Alphasights. Please let me know if you have any questions regarding it, at tristanjmccormick@gmail.com

The bulk of the program is contained in the Email_Prediction_Module, wherein the logic is stored for parsing incoming email
addresses for their email formats and processing new name-domain pairs pursuant to those email formats.

The EmailObject class holds the state of instances of an email. This state includes full name and email, first and last name,
first and last local parts of the email, the domain of the email and finally the email format that was used to create the email address.
When this object is initialized, it is passed two optional parameters, a name and an email. Depending on which is present,
the Initialize method will break the parameter down into its constituent parts and store them accordingly.

The EmailPredictionObject holds the hash of incoming name-email pairs as well as the hash of incoming name-company pairs for
which we are predicting emails. When initialized, it processes the first hash, storing the results in a hash of email objects
and calculating the email formats for all of the provided domains. Note that where it sees conflicting email formats for the
same domain, it stores all possible formats.

Calling the predict_email method does the bulk of the challenge's work, determining all possible emails for the names provided in the 
second hash. Note that this predict_email method operates "in place" on already created email objects. So for now, the return value
for generate_email_address is not used. I left it because it has obvious future uses, namely if Alphasights wanted to do something
with the generated email address other than just print them out to the user.

There are a number of things that are missing from this application not the least of which is a testing framework of some kind.
Rather than do the research necessary to find a good one, having never worked on a Ruby application before much less automated tests
for one, I thought I would just send in my code. But as I said let me know if you have any thoughts, I welcome your critique!

Thanks very much



Tristan McCormick

