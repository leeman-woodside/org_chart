require 'active_record'
require 'csv'

class Export
  def self.export_to_csv
    CSV.generate(headers: true) do |csv|
      # CSV headers
      csv << ['Contributor email','Squad name','Squad DRI email','Group name','Group DRI email','Chapter name','Chapter DRI email','Department name','Department DRI email']

      # Fetch all squads with associated users
      Squad.includes(:users).find_each do |squad|
        squad.users.each do |user|
          contributor_email = user.email

          # Add each user with their squad information to the CSV row
          csv << [contributor_email, squad.name]

          # squad.dri_email, squad.group_name, squad.group_dri_email, squad.chapter_name, squad.chapter_dri_email, squad.department_name, squad.department_dri_email
        end
      end
    end
  end
end