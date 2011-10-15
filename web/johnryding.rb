################################################################################
# Dependencies                                                                 #
################################################################################
require 'rubygems' # required to place gems on LOAD_PATH

require 'sinatra' # web framework
require 'rdiscount' # markdown template engine

require "logger" # Ruby's logging lib

################################################################################
# Sinatra Settings                                                             #
################################################################################

# Set the directory to server static files (css, js, images) from.
set :public_folder, File.join( File.dirname(__FILE__), 'assets' )

################################################################################
# Constants / Globals                                                          #
################################################################################

WEB_APP_ROOT = settings.root
MARKDOWN_DIR = File.join( WEB_APP_ROOT, "text" )
CACHE_DIR = File.join( WEB_APP_ROOT, "cache" )

################################################################################
# Web App Logic                                                                #
################################################################################

get '/' do
  @title = "Home"
  erb :layout, :locals => { :text => get_markdown_content("home") }
end

get '/about' do
  @title = "About"
  erb :layout, :locals => { :text => get_markdown_content("about") }
end

get '/setup' do
  @title = "Setup"
  erb :layout, :locals => { :text => get_markdown_content("setup") }
end

get '/projects' do
  @title = "Projects"
  erb :projects
end

################################################################################
# Helper Methods                                                               #
################################################################################

def get_markdown_path(uri)

  page_path = File.join( MARKDOWN_DIR, uri )
  
  if File.directory?(page_path)
    page_path = File.join( page_path, "index" )
  end
  
  return page_path << ".md"
  
end

def write_to_cache_dir(file_name, content)
  cache_file = File.join( CACHE_DIR, file_name )
  
  File.open(cache_file, "w") do |file|
    file.puts content
  end
end

def render_markdown(markdown_file)
  
  # Check if the markdown_file exists in the cache directory and if it has not
  # been modified since added to the cache
  cache_file = File.join( CACHE_DIR, File.basename(markdown_file))
  
  unless File.directory?(CACHE_DIR) then
    Dir.mkdir(CACHE_DIR)
  end
  
  if File.exists?(cache_file) and ( File.mtime(markdown_file) <=> File.mtime(cache_file) ) == -1
    return File.read(cache_file)
  end
  
  # if the file does not exist, render the markdown, create
  text = File.read(markdown_file)
  markdown_text = RDiscount.new(text).to_html
  write_to_cache_dir(File.basename(markdown_file), markdown_text)
  
  return markdown_text
  
end

def get_markdown_content(page)
  markdown_file = get_markdown_path(page)
  
  unless File.exists?(markdown_file) then
    raise Sinatra::NotFound
  end
  
  return render_markdown(markdown_file)
end