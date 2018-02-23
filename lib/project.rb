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
  end

  def ==(new_project)
    self.title.==(new_project.title)
  end

  def self.all
    db_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    db_projects.each do |project|
      title = project.fetch('title')
      id = project.fetch('id').to_i
      projects.push(Project.new({:title => title, :id => id}))
    end
    return projects
  end

  def self.find(id)
    located_project = nil
    Project.all.each do |project|
      if project.id.==(id)
        located_project = project
      end
    end
    located_project
  end

end # project
