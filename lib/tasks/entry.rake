# lib/tasks/entry.rake
# Usage: 
#   Production: heroku run rake entry:category:change_dreams
#   Development: rake entry:category:change_dreams
# Scenario: For example, we added sleep to the dreams category. The chart messed
# up and we have to rename all the old attributes from dreams to dreams/sleep
namespace :entry do
  namespace :category do
    desc "Change all entry categories where the category is dreams to dreams/sleep"
    task change_dreams: :environment do
      Entry.where(category: 'dreams').update_all(category: 'dreams/sleep')
    end
  end
end