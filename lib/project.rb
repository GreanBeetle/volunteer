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

end # project
