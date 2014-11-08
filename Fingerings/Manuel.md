#Manuel pour la rédaction des lignes de doigtés

Un doigté est indiqué par le numéro du doigt (de 1 à 5)&nbsp;:

    1

L'intervalle par défaut entre deux doigtés est la seconde (2). Lorsque cet intervalle est plus grand, on peut l'indiquer après un tiret&nbsp;:

    1 2-3
    
    => Le doigt 2 suit le doigt 1 en parcourant une tierce

Les phrases sont délimitées par des points (".")&nbsp;:

    1 2 3 4 5 . 1 2 3

Elles permettent d'effecture des répétitions, en indiquant le nombre de fois à la fin de la phrase par un "*". Par exemple pour répéter la première phrase 3 fois&nbsp;:

    1 2 3 4 5 *3 . 1 2 3

Noter dès à présent un détail important&nbsp;: le dernier doigté de la phrase sera lié au premier le nombre de fois voulu. Ici, le `5` sera lié au `1` trois fois. On obtiendra donc :
    1 2
    2 3
    3 4
    4 5
    5 1
    x 3

Ensuite le `5` sera lié au `1` de la phrase suivante.

Une ligne doit OBLIGATOIREMENT contenir au moins deux phrases. La dernière phrase est appelée à la “CODA” et ne doit pas être répétée.

Deux doigtés identiques ne sont jamais pris en compte. Dans la phrase&nbsp;:

    1 2 3 1 *2

… le doigt 1->1 qui résulte de la reprise ne sera pas considéré.

Il en va de même de l'enchaînement d'une phrase à une autre&nbsp;:

    1 2 3 1 . 1 2 4

Quand un écart est indiqué sur la première note, c'est que la phrase se répète avec cet écart. Par exemple&nbsp;:

    1-4 2 3 *2

    => L'enchainement 3->1 forme une quarte (4)

Il est possible de l'indiquer aussi avec un doigté entre parenthèses&nbsp;:

    1 2 3 (1-4) *2 . 5 4 3
    
    => Dans ce cas, c'est l'enchainement 3->1 qu'on aura à la reprise et
       l'enchainement 3->5 qu'on aura pour le passage à la phrase suivante.

##Notations complexes

    1 2 3 (5-3) . 5-6 4 1 *2 . 3 2 1
  
Dans cette notation, le doigté `3` s'enchaine au doigté `5` en formant une tierce, mais ce `5`, entre parenthèses est le même que le `5` de la phrase suivante qui lui forme un écart de sixte (6) à la reprise de la phrase, après le 1. On obtient donc les enchainements&nbsp;:

    1   2
    2   3
    3   5-3
    5   4
    4   1
    5-6 4
    4   1
    etc.