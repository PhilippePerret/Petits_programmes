class Finger
  
  attr_reader   :phrase
  attr_accessor :indice
  attr_reader   :finger_str       # Le doigté tel que fourni à l'instanciation
  attr_reader   :finger           # {Fixnum} Le doigté seul
  attr_reader   :intervalle       # {Fixnum} L'intervalle avec la note précédente
  
  def initialize phrase, str
    raise "Le premier argument doit être la phrase du doigté" unless phrase.class == Phrase
    @phrase     = phrase
    @finger_str = str
    analyse
  end
  
  def analyse
    @is_in_parentheses = @finger_str.start_with?('(')
    @finger = @is_in_parentheses ? @finger_str[1..-2] : @finger_str
    @finger, @intervalle = @finger.index('-') ? @finger.split('-') : [@finger, "1"]
    @finger = @finger.to_i
    @intervalle = @intervalle.to_i
  end
  
  # True si le doigté se trouve entre parenthèses
  def in_parentheses?
    @is_in_parentheses
  end
  
  # raccourci
  def exercice
    @exercice ||= phrase.exercice
  end
    
  # Doigté précédent dans la phrase
  def prev
    @prev ||= ( indice == 0 ? nil : phrase.fingers[indice - 1])
  end
  
  # Doigté suivant dans la phrase
  def next
    @next ||= phrase.fingers[indice + 1]
  end
  
end