namespace :util do

  desc "reset all votes"
  task :reset_votes => :environment do |t, args|
    Hack.all.each do |hack|
      hack.upvoted_by = []
      hack.save
    end

    puts "Destroyed all votes in the " + Rails.env + " environment"
  end

end