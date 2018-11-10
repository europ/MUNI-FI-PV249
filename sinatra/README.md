MuniHub Sinatra Project
=====================

V tomto adresáři vytvořte jednoduchou webovou službu na práci s git repozitáři.
Tato služba zpřístupní vybranou sadu git operací.

Použití
-------

```
munihub_backend.rb
```

Seznam end-pointů:

1. `GET /repositories/:owner/:repository_name` - vrátí základní informace o repozitáři (sha posledního commitu ve výchozí větvi, cesta k repozitáři, kterou jde použít pro `git clone`)
2. `POST '/repositories/:owner/:repository_name`` - vytvoří nový repozitář, vrátí status `409` v případě, že daný adresář už existuje
3. `GET /repositories/:owner/:repository_name/ref/:ref/files/*:path` - vrátí seznam souborů v daném podadresáři, `:ref` odpovídá identifikaci
   commitu v gitu, může to být název větve (`master`) nebo sha commitu (`f2b7c8274b`)
   
Aplikace si bude udržovat vlastní úložiště spravovaných git repozitářů. Pro jednoduchost můžeme předpokládat, že klienti budou mít
k tomu úložišti lokální přístup. Úložiště repozitářů, jako i jejich veřejná adresa bude nastavitelná pomocí konfiguračního souboru.

Testy
-----

Jeden z nutných, nikoliv však postačujících, požadavků je úspěšné procházení
testů, které jsou součástí zadání.

Pro spuštění testů:

```
# Run rubocop and tests
bundle exec rake

# Run only rubocop
bundle exec rubocop

# Run only tests
bundle exec rake test

# Run a specific test
ruby -I . test/munihub_test.rb -n '/fails with appropriate message when test fails/'
```
