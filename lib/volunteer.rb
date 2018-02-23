require 'pry'

class Volunteer
  attr_accessor :name, :project_id, :id

  def initialize(attributes)
    @name = attributes[:name]
    @project_id = attributes[:project_id]
    @id = attributes[:id]
  end

  def name
    @name
  end

  def project_id
    @project_id
  end

  def ==(new_volunteer)
    self.name.==(new_volunteer.name)
  end

  def save
    var = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', '#{@project_id}') RETURNING id;")
    @id = var.first.fetch('id').to_i
  end

  def self.all
    db_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    db_volunteers.each do |volunteer|
      name = volunteer.fetch('name')
      project_id = volunteer.fetch('project_id').to_i
      id = volunteer.fetch('id').to_i
      volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    return volunteers
  end

end # Volunteer
