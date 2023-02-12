# Racerbils-evolution

Dette program bygger vidre på den udleverede kode.

Programmet bruger en genetisk algoritme til at udvikle racer bilernes evne til at køre en omgang hurtigst.

Algoritmens fitness funktion er baseret på clockWiseRotationFrameCounter variablen i Sensor klassen, plussede med hvor mange frames to tog for bilen at køre en omgang. Dette vil gøre at algoritmen vil vægte mest på om bilen har kørt en omgang rundt om banen og hvor hurtigt den gjorde det.

Måden "Reproduction" er at den vil både kombinere to Parent's "weight" værdier, og deres "biases" værdier. Måden den kombinere dem på er at de vælger et tilfældigt midtpoint or så bliver parentA's værdier overført hvis deres arrayIndex er under midtpoint, og hvis det er over midtpoint så overfør fra ParentB. Desuden er der også en mutationRate på 4% som kan ændre et af weight eller biases værdier til et tilfældigt tal basseret på CarControlleren Varians.

Hvis nogle af billerne rammer et hvidt spot eller når målstregen stopper de. Dette gøre det nemmere at bedømme om hvor langt bilen har nået eller hvor hurtigt den kom i mål.

Programmet indeholder også meget statistik omkring statusen af bilerne og generationer, såsom generations tallet, gennemsnit af fitness, hvor mange biler der er aktiv osv.

Man kan trykke på R for at starte en ny generation. Det anbefaldes at man venter indtil de fleste af bilerne ikke længere er aktiv eller ikke længere laver fremskridt før man starter en ny generation.
