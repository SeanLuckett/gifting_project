namespace :recommendations do

  desc "Send emails to User for a recipient associated with an event."
  task :send_email, [:num_weeks] => :environment do |t, args|
    # the following is hard-coded for demo purposes
    user = User.find_by_name("Sean Luckett")
    event = (Event.priority(args.num_weeks.to_i, user.id)).first
    recipient = event.recipients.first

    # Eventually, this would happen for every recipient on an event and every event
    # within :num_weeks of today
    user.send_recommendation(recipient, event)
    puts "Email sent to #{user.name} for #{recipient.name}'s gift on #{event.title}"
  end

end
