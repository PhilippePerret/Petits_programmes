#!/usr/bin/env ruby
=begin
Programme qui prend le fichier 'fingerings.txt' et calcule la fréquence des doigtés

=end
THIS_FOLDER = File.dirname(__FILE__)
Dir.chdir(THIS_FOLDER) do
  require './lib/required'

  if ARGV.length > 0
    fingerings_file = ARGV.shift
  else
    Etude::output_format = :html
    fingerings_file = './fingerings.txt'
  end

  Etude::fingerings_path = fingerings_file
  # Pour n'étudier qu'un rang d'exercices
  # Etude::from_exercice = 1
  # Etude::to_exercice   = 20

  Etude::verbose = false
  Etude::start
  Etude::print_bilan
end