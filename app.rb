require 'sinatra'
require 'sinatra/reloader'
require 'pry'
also_reload('lib/**/*.rb')
require './lib/project'
require './lib/volunteer'
require 'pg'

DB = PG.connect({:dbname => 'volunteer_tracker'})

get('/') do
  @projects = Project.all
  erb(:home)
end

post('/home') do
  title = params[:title]
  project = Project.new({:title => title})
  project.save
  @projects = Project.all
  erb(:home)
end

get('/project/:id') do
  id = params[:id].to_i
  @project = Project.find(id)
  @title = @project.title
  erb(:project)
end

get('/project/:id/change') do
  id = params[:id].to_i
  @project = Project.find(id)
  @title = params[:new_title]
  @project.update({:title => @title, :id => id})
  erb(:project)
end

# post('/project/:id/change') do
#   @title = params[:new_title]
#   id = params[:id].to_i
#   @project = Project.find(id)
#   binding.pry
#   # @project.update({:title => @title, :id => id})
#   erb(:project)
# end
