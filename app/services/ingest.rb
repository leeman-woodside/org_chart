require 'active_record'
require 'csv'

class Ingest
  def self.process_csv(file)
    CSV.foreach(file, headers: true) do |row|

      dri_email = row['Squad DRI email']
      contributor_email = row['Contributor email']

      dri_user = User.find_or_create_by(email: dri_email)
      contributor_user = User.find_or_create_by(email: contributor_email)

      # Assign squad_id to users if available
      squad_name = row['Squad name']
      squad = Squad.find_or_create_by(name: squad_name)

      chapter_name = row['Chapter name']
      group_name = row['Group name']
      department_name = row['Department name']

      # Create or find rest of the squads
      Squad.find_or_create_by(name: chapter_name)
      Squad.find_or_create_by(name: group_name)
      Squad.find_or_create_by(name: department_name)

      dri_user.update(squad_id: squad.id) if dri_user.squad_id.nil?
      contributor_user.update(squad_id: squad.id) if contributor_user.squad_id.nil?
    end
  end
end