bibtex2html -nobibsource GabrielRenaudCV_published.bib


/bin/sed -i -r ':a;$!{N;ba};s/(Gabriel[^\n]*)\n/\1 /g' GabrielRenaudCV_published.html
/bin/sed -i  "s/Gabriel Renaud/<b>Gabriel Renaud<\/b>/g" GabrielRenaudCV_published.html


cat publicationsh.html <(/bin/grep -A 100000 "<table>" GabrielRenaudCV_published.html |head -n-3 | /bin/sed "s/\/table>.*/\/table>/g") publicationst.html > publications.html

