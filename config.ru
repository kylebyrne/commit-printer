require_relative "app"
App.freeze unless ENV["RACK_ENV"] == "development"
run App.app
