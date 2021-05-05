===============================================================================
NÁVOD NA POUITÍ:
===============================================================================

1) Zkopírujte Váš .zip archiv pøipravenı na odevzdání do WIS do této sloky.

2) Hodnotu svého loginu vlote do promìnné LOGIN ve skriptu test.bat.

3) Spuste test projektu voláním skriptu test.bat.

===============================================================================
VİSTUPY:
===============================================================================

standardní vıstup - Struènı pøehled prùbìhu a vısledku testu.

work/ - Sloka obsahující pracovní soubory vytvoøené v prùbìhu testu.

work/log/ - Sloka obsahující podrobnosti o prùbìhu jednotlivıch krokù testu.

POZN1: Test nekontroluje obsah dokumentace, ale pouze její existenci.
POZN2: Vısledky testu jsou pouze orientaèní a mohou se lišit od koneèného
       hodnocení projektu. V zásadì ale, pokud test objeví nìkterı nedostatek, 
       je vysoce pravdìpodobné, e se tento nedostatek objeví i pøi hodnocení.


===============================================================================
CO TEST.BAT DÌLÁ:
===============================================================================

1) Nejprve si rozbalí vstupní .zip archiv a zkontroluje, zda obsahuje všechny
   poadované soubory ve správnıch slokách.

2) Spustí simulaci projektu v prostøedí ModelSim.

3) Provede ohodnocení dosaenıch vısledkù, tj. porovná odpovìdi v log
   souborech získanıch v kroku (2) se vzorovımi odpovìïmi.
