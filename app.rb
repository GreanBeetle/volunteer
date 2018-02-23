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
  @volunteers = Volunteer.all
  erb(:project)
end

get('/project/:id/change') do
  id = params[:id].to_i
  @project = Project.find(id)
  @title = params[:new_title]
  @project.update({:title => @title, :id => id})
  @volunteers = Volunteer.all
  erb(:project)
end

get('/project/:id/delete') do
  id = params[:id].to_i
  @project = Project.find(id)
  @project.delete
  erb(:delete)
end

post('/project/:id/volunteer') do
  project_id = params[:id].to_i
  volunteer_name = params[:volunteer]
  @project = Project.find(project_id)
  @title = @project.title
  @volunteer = Volunteer.new({:name => volunteer_name, :project_id => project_id, :id => nil})
  @volunteer.save
  @volunteers = Volunteer.all
  erb(:project)
end

get('/volunteer/:id') do
  volunteer_id = params[:id].to_i
  @volunteer = Volunteer.find(volunteer_id)
  @name = @volunteer.name
  erb(:volunteer)
end














# end
