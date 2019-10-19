MuniHub Sinatra Project
=====================

V tomto adresáři vytvořte jednoduchou webovou službu na práci s git repozitáři.
Tato služba zpřístupní vybranou sadu git operací.

Použití
-------

### Spuštění ###


```
bundle exec bin/munihub_git.rb
```

### Seznam end-pointů ###

1. `GET /repositories/:owner/:repository_name` - vrátí základní informace o
   repozitáři (sha posledního commitu ve výchozí větvi, cesta k repozitáři,
   kterou jde použít pro `git clone`). Příklad:
   
   ```
   {"repository":{"head":"d8a958d5f561b6383159cdc3705129f5cb5a2a15",
                  public_path":"/home/inecas/Projects/school/MuniHub/sinatra/data/repositories/my_owner/my_repo"}} 
   ```

2. `POST '/repositories/:owner/:repository_name` - vytvoří nový repozitář.
   V případě úspěchu vrátí:
   ```
   {"message":"Repository created"} 
   ```

   V případě, že repozitář už existuje, vrátí kód 409, s následující odpovědí:
   ```
   {"message":"Repository already exists"}
   ```


3. `GET /repositories/:owner/:repository_name/refs/:ref/files/*:path` - vrátí
   seznam souborů v daném podadresáři, `:ref` odpovídá identifikaci
   commitu v gitu, může to být název větve (`master`) nebo sha commitu (`f2b7c8274b`).
   
   Příklad výstupu:
   ```
   {
       "files": [
           {
               "name": "README.md",
               "type": "file"
           },
           {
               "name": "lib",
               "type": "dir"
           }
       ]
   }
   ```

3. `GET /repositories/:owner/:repository_name/refs/:ref/commits` - vrátí seznam
   commitů v daném vetvi
   
   Příklad výstupu:
   ```
   {
       "commits": [
           {
               "sha": "c0ff924a366b6fbc33a2ca2ce2509dfa43afc0a0",
               "author": "inecas@redhat.com",
               "subject": "Second commit"
           },
           {
               "sha": "df9c24c1528ba6ef0c084eeeb4d862b7db5be30d",
               "author": "inecas@redhat.com",
               "subject": "First commit"
           }
       ]
   }
   ```
   
Aplikace si bude udržovat vlastní úložiště spravovaných git repozitářů. Pro
jednoduchost můžeme předpokládat, že klienti budou mít k tomu úložišti lokální
přístup. Úložiště repozitářů, jako i jejich veřejná adresa bude nastavitelná
pomocí konfiguračního souboru.

### Konfigurace ###

Aplikace bude nastavitelná pomocí konfiguračního souboru. Cesta k souboru bude
určená pomocí proměnné prostředí `ENV['MUNIHUB_GIT_CONFIG_FILE']`. Když nebude uvedena,
výchozí cesta je `munihub_git.yml`.

Ukázková konfigurace může vypadat takto:

```yaml
:repositories_dir: data/repositories
# %{relative_path} bude nahrazena cestou 'owner/repository_name' podle aktuálního adresáře
:public_path: file:///home/myuser/Projects/munihub/sinatra/data/repositories/%{relative_path}
```

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
bundle exec ruby -I . test/munihub_git_test.rb -n '/shows files in root dir of master branch/'

# Run a specific test, with debug info from running the commands
DEBUG_COMMANDS=true bundle exec ruby -I . test/munihub_git_test.rb -n '/shows files in root dir of master branch/'
```
