require 'pry'

class Project
  attr_accessor :title, :id, :volunteer_id

  def initialize(attributes)
    @title = attributes[:title]
    @id = attributes[:id]
  end

  def title
    @title
  end

  def id
    @id
  end

  def save
    var = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = var.first.fetch('id').to_i
    binding.pry
  end

  def ==(new_project)
    self.title.==(new_project.title)
  end

end # project
