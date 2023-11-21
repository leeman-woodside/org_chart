require 'active_record'
require 'csv'

class Ingest
  def self.process_csv(file)
    CSV.foreach(file, headers: true) do |row|
      # CSV has columns named:
      # Contributor email 
      # Squad name 
      # Squad DRI email
      # Group name 
      # Group DRI email 
      # Chapter name 
      # Chapter DRI email 
      # Department name 
      # Department DRI email
      # Create or find the users
      dri_email = row['Squad DRI email']
      contributor_email = row['Contributor email']

      dri_user = User.find_or_create_by(email: dri_email)
      contributor_user = User.find_or_create_by(email: contributor_email)

      # Assign squad_id to users if available
      squad_name = row['Squad name']
      squad = Squad.find_or_create_by(name: squad_name)

      dri_user.update(squad_id: squad.id) if dri_user.squad_id.nil?
      contributor_user.update(squad_id: squad.id) if contributor_user.squad_id.nil?
    end
  end
end