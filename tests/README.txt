===============================================================================
N�VOD NA POU�IT�:
===============================================================================

1) Zkop�rujte V� .zip archiv p�ipraven� na odevzd�n� do WIS do t�to slo�ky.

2) Hodnotu sv�ho loginu vlo�te do prom�nn� LOGIN ve skriptu test.bat.

3) Spus�te test projektu vol�n�m skriptu test.bat.

===============================================================================
V�STUPY:
===============================================================================

standardn� v�stup - Stru�n� p�ehled pr�b�hu a v�sledku testu.

work/ - Slo�ka obsahuj�c� pracovn� soubory vytvo�en� v pr�b�hu testu.

work/log/ - Slo�ka obsahuj�c� podrobnosti o pr�b�hu jednotliv�ch krok� testu.

POZN1: Test nekontroluje obsah dokumentace, ale pouze jej� existenci.
POZN2: V�sledky testu jsou pouze orienta�n� a mohou se li�it od kone�n�ho
       hodnocen� projektu. V z�sad� ale, pokud test objev� n�kter� nedostatek, 
       je vysoce pravd�podobn�, �e se tento nedostatek objev� i p�i hodnocen�.


===============================================================================
CO TEST.BAT D�L�:
===============================================================================

1) Nejprve si rozbal� vstupn� .zip archiv a zkontroluje, zda obsahuje v�echny
   po�adovan� soubory ve spr�vn�ch slo�k�ch.

2) Spust� simulaci projektu v prost�ed� ModelSim.

3) Provede ohodnocen� dosa�en�ch v�sledk�, tj. porovn� odpov�di v log
   souborech z�skan�ch v kroku (2) se vzorov�mi odpov��mi.
