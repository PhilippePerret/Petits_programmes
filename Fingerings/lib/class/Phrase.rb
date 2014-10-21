class Phrase

  attr_reader   :exercice       # Instance ExerciceFingers
  attr_reader   :phrase_str     # String
  attr_accessor :indice         # Fixnum - Indice de la phrase dans l'exercice
  attr_reader   :nombre_fois    # Fixnum
  attr_reader   :fingers_str    # String (seulement les doigtés)
  attr_reader   :fiingers       # Array d'instance Finger


  def initialize exercice, phrase_str
    raise "Le premier argument doit être l'exercice" unless exercice.class == ExerciceFingers
    @exercice   = exercice # instance ExerciceFingers
    @phrase_str = phrase_str
    analyse
  end
  
  
  def analyse
    fings, nb = phrase_str.split('*')
    @nombre_fois = nb.nil? ? 1 : nb.to_i
    @fingers_str = fings.strip
  end
  
  def fingers
    @fingers ||= begin
      ind = -1
      @fingers_str.split(' ').collect do |fing|
        fg = Finger::new self, fing
        fg.indice = ( ind += 1 )
        fg
      end
    end
  end
  
  # retourne le vrai dernier doigté (en tenant compte des parenthèses)
  def real_last_finger
    @real_last_finger ||= begin
      if fingers.last.in_parentheses?
        fingers.last.prev
      else
        fingers.last
      end
    end
  end
  
  # Return true si la phrase est la coda
  def coda?
    @is_coda ||= self.next.nil?
  end
  
  # Retourne la phrase suivante
  def next
    @next ||= exercice.phrases[indice + 1]
  end
  
  # Retourne la phrase précédente
  def prev
    @prev ||= ( indice == 0 ? nil : exercice.phrases[indice - 1] )
  end
  
end
