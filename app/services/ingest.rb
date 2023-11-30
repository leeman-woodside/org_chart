require 'active_record'
require 'csv'

class Ingest
  def self.process_csv(file)
    CSV.foreach(file, headers: true) do |row|

      # gather all the emails for Contributors and DRIs
      squad_dri_email = row['Squad DRI email']
      group_dri_email = row['Group DRI email']
      chapter_dri_email = row['Chapter DRI email']
      department_dri_email = row['Department DRI email']
      contributor_email = row['Contributor email']

      squad_name = row['Squad name']
      chapter_name = row['Chapter name']
      group_name = row['Group name']
      department_name = row['Department name']
      
      squad = Squad.find_or_create_by(name: squad_name)
      chapter = Squad.find_or_create_by(name: chapter_name)
      group = Squad.find_or_create_by(name: group_name)
      department = Squad.find_or_create_by(name: department_name)

      # Populate the users table
      squad_dri_user = User.find_or_create_by(email: squad_dri_email)
      group_dri_user = User.find_or_create_by(email: group_dri_email)
      chapter_dri_user = User.find_or_create_by(email: chapter_dri_email)
      department_dri_user = User.find_or_create_by(email: department_dri_email)
      contributor_user = User.find_or_create_by(email: contributor_email)
  
      # Update DRI IDs for each squad level
      squad.update(dri_id: squad_dri_user.id)
      group.update(dri_id: group_dri_user.id)
      chapter.update(dri_id: chapter_dri_user.id)
      department.update(dri_id: department_dri_user.id)
  
      # Assign squad_id to users if available
      contributor_user.update(
        squad_id: squad.id, 
        group_id: group.id,
        chapter_id: chapter.id,
        department_id: department.id)
    end
  end
end