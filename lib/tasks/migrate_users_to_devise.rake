# Usage:
#   Production: heroku run rake user:generate_random_password
#   Development: rake user:generate_random_password
# Scenario: Assign an new random password for each user and send them a email notification
namespace :user do
  desc "Migrate users to devise"
  task generate_random_password: :environment do
    model = ENV['MODEL'] || 'User'
    begin
      model_mailer = "#{model}Mailer".constantize
      model = model.constantize

      puts "searching for user with blank passwords"
      model.where(encrypted_password: "").each do |record|
        puts "found #{record.email}" if record
        # Assign a random 8 character password
        random_password = Devise.friendly_token.first(8)
        record.password = random_password
        record.save!
        puts "successfully assigned new random password"
        model_mailer.password_reset_email(record, random_password).deliver
        puts "and sent by email to #{record.email}"
      end
    rescue Exception => e
      puts "Error: #{e.message}"
    end
  end
end
