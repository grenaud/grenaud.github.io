bibtex2html -nobibsource GabrielRenaudCV_published.bib


sed -i -r ':a;$!{N;ba};s/(Gabriel[^\n]*)\n/\1 /g' GabrielRenaudCV_published.html
sed -i  "s/Gabriel Renaud/<b>Gabriel Renaud<\/b>/g" GabrielRenaudCV_published.html


cat publicationsh.html <(grep -A 100000 "<table>" GabrielRenaudCV_published.html |head -n-3 | sed "s/\/table>.*/\/table>/g") publicationst.html > publications.html

