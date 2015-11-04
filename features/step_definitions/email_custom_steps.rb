Then /^"([^\"]*)" should be emailed$/ do |user|
  @user = User.find_by_login(user)
  emails("to: \"#{email_for(@user.email)}\"").size.should > 0
end

Then /^the email to "([^\"]*)" should contain "([^\"]*)"$/ do |user, text|
  @user = User.find_by_login(user)
  email = emails("to: \"#{email_for(@user.email)}\"").first
  if email.multipart?
    email.text_part.body.should =~ /#{text}/
    email.html_part.body.should =~ /#{text}/
  else
    email.body.should =~ /#{text}/
  end
end

Then /^the email to "([^\"]*)" should not contain "([^\"]*)"$/ do |user, text|
  @user = User.find_by_login(user)
  email = emails("to: \"#{email_for(@user.email)}\"").first
  if email.multipart?
    email.text_part.body.should_not =~ /#{text}/
    email.html_part.body.should_not =~ /#{text}/
  else
    email.body.should_not =~ /#{text}/
  end
end

Then /^"([^\"]*)" should not be emailed$/ do |user|
  @user = User.find_by_login(user)
  emails("to: \"#{email_for(@user.email)}\"").size.should == 0
end
