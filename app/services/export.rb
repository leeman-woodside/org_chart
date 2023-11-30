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
          group_id = user.group_id
          chapter_id = user.chapter_id
          department_id = user.department_id

          group = Squad.find_by(id: group_id)
          chapter = Squad.find_by(id: chapter_id)
          department = Squad.find_by(id: department_id)
          
          squad_dri_user = User.find_by(id: squad.dri_id)
          group_dri_user = User.find_by(id: group.dri_id)
          chapter_dri_user = User.find_by(id: chapter.dri_id)
          department_dri_user = User.find_by(id: department.dri_id)


          # Add each user with their squad information to the CSV row
          csv << [contributor_email, squad.name, squad_dri_user.email, group.name, group_dri_user.email, chapter.name, chapter_dri_user.email, department.name, department_dri_user.email]
        end
      end
    end
  end
end