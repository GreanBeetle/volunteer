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
