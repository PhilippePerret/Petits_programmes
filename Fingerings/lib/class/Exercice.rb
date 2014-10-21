class ExerciceFingers
  
  attr_reader :ligne_doigtes
  
  def initialize ligne
    @ligne_doigtes = ligne
  end
  
  # = Main =
  #
  # Fait l'étude de l'exercice
  def etudie
    (0..phrases.count - 1).each do |iphrase|
      laphrase = phrases[iphrase]
      Etude::dbg "- Étude de la phrase : #{laphrase.fingers_str}"
      laphrase.fingers.each do |fing|
        # Si c'est le dernier doigté de la coda, pas de
        # recherche de combinaison
        break if fing.next.nil? && laphrase.coda?
        
        # Le doigté de comparaison (suivant ou premier sauf si c'est le même)
        fcomp = fing.next || laphrase.fingers.first
        next if fing.finger == fcomp.finger
        
        # La combinaison de doigts
        combi = "#{fing.finger}-#{fcomp.finger}"
        inter = fcomp.intervalle # TODO: Sera à affiner

        Etude::add_data combi, laphrase.nombre_fois, inter
        
      end # fin de boucle sur les doigtés de la phrase

      # Liaison avec la phrase suivante si elle existe
      unless laphrase.next.nil?
        Etude::dbg "La phrase suivante existe, j'étudie la liaison"
        # Si le dernier doigté de la phrase est entre parenthèse,
        # c'est le doigté précédent qu'il faut prendre. C'est la fonction
        # de la méthode `real_last_finger'
        dernier_doigte = laphrase.real_last_finger
        premier_doigte = laphrase.next.fingers.first
        
        # Si le doigt est le même => pas de liaison
        unless dernier_doigte.finger == premier_doigte.finger
          intervalle  = premier_doigte.intervalle # TODO: AFFINER
          combi       = "#{dernier_doigte.finger}-#{premier_doigte.finger}"
          nbfois      = 1

          Etude::add_data combi, nbfois, intervalle
        end
      end      
    end
  end
  
  def empty?
    @is_empty ||= @ligne_doigtes == ""
  end
  
  # Retourne les phrases sous forme de liste Array d'instances Phrase
  # Numérote (indice) chaque phrase
  def phrases
    @phrases ||= begin
      indice = -1
      @ligne_doigtes.split(".").collect do |e| 
        phr = Phrase::new self, e.strip
        phr.indice = indice += 1
        phr
      end
    end
  end
  
  # La code, donc la dernière phrase (instance {Phrase})
  def coda
    @coda ||= phrases.last
  end
  
end
