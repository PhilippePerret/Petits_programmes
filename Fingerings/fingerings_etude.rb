#!/usr/bin/env ruby
=begin
Programme qui prend le fichier 'fingerings.txt' et calcule la fréquence des doigtés

Note sur l'écriture des exercices :
  * TEST OK Chaque ligne correspond à un exercice
  * TEST OK Les exercices à notes répétées sont passés (cf. ci-dessous)
  * Chaque "phrase" est délimitée par un ".". Le dernier doigté est considéré comme
    s'enchaînant au premier, 
    TEST OK SAUF si le doigt est le même à la fin et au début
  * Les lignes vides sont passées (pour correspondre au numéro de l'exercice quand
    des exercices sont exclus)
  * La dernière note d'une phrase s'enchaine à la première note de la phrase suivante
    TEST OK : SAUF si c'est le même doigt.
  * Si la dernière note d'une phrase est entre parenthèses, cela représente la
    "retombée" de la mesure suivante (donc la première note de la phrase). C'est
    alors la note précédente qui doit être enchainée à la phrase suivante.
  * La toute dernière phrase doit être la fin exacte. Appelée "coda"
  * L'avant-dernière phrase s'enchaine 1 fois à la toute première.

Exemples particuliers :

    ... 4 (5) . 4 3 2 1
    # Ci-dessus, le "(5)" est exclus pour considéré l'enchaînement à la phrase suivante
      puisqu'il est entre parenthèses. Et puisque le 4 suit un 4, on considère qu'il n'y
      a aucune liaison entre les deux phrases.

=end
require './lib/required'

# Pour n'étudier qu'un rang d'exercices
# Etude::from_exercice = 1
# Etude::to_exercice   = 20

Etude::verbose = false
Etude::start
Etude::print_bilan