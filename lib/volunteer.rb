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

end # Volunteer
