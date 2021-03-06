# require 'capybara/rspec'
# # require 'rspec-steps'
# require 'rspec-html-matchers'
#
# # Capybara.javascript_driver = :webkit
# Capybara.javascript_driver = :selenium
# Capybara.default_driver = :selenium
#
# Dir["./spec/support/**/*.rb"].each {|f| require f}

# Toute les classes
require './lib/required'


RSpec.configure do |config|
  
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  
  config.before :all do |x|

  end
  
  config.before :each do |x|

  end
  
  config.after :all do

  end

  # À jouer tout au début des tests
  # -------------------------------
  config.before :suite do
  end
  
  # À jouer tout à la fin des tests
  # --------------------------------
  config.after :suite do
  end  
  
  #---------------------------------------------------------------------
  #   Tests
  #---------------------------------------------------------------------
  # Pour savoir où se trouve le fichier test, on peut ajouter dans le
  # premier describe : "<nom du test> (#{relative_path(__FILE__)})"
  def relative_path path
    name = File.basename(path)
    doss = File.basename(File.dirname(path))
    ddos = File.basename(File.dirname(File.dirname(path)))
    " (#{ddos}/#{doss}/#{name})"
  end
  
  #---------------------------------------------------------------------
  #   Méthodes utilitaires
  #---------------------------------------------------------------------
  

  # ---------------------------------------------------------------------
  #   Screenshots
  # ---------------------------------------------------------------------
  # def shot name
  #   name = "#{Time.now.to_i}-#{name}"
  #   page.save_screenshot("./spec/screenshots/#{name}.png")
  # end
  # def empty_screenshot_folder
  #   p = './spec/screenshots'
  #   FileUtils::rm_rf p if File.exists? p
  #   Dir.mkdir( p, 0777 )
  # end
  #

  # empty_screenshot_folder

end

