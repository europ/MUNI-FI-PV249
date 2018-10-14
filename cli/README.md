MuniHub CLI Project
=====================

V tomto adresáři vytvořte jednoduchou command-line aplikaci na vytváření
pull-requestů do naší služby. `munihub.rb` se používá z uvnitř git repozitáře.

Použití
-------

```
munihub.rb pull-request [-b base_branch]
```

1. Vezme commity které jsou nové oproti `base_branch` (`master` by defualt) a
   otevře editor (použitím proměnné prostředí `EDITOR`), ve kterém bude
   předvyplněný text pro nový pull-request na základe commit message. V případě,
   že je těch commitů víc, bude v editoru text všech commitů, ale bude
   zakomentován (`# ` na začátku řádku).

2. Jakmile uzivatel uloží zmeny v dokmentu a ukončí editor, skript zkontroluje,
   že text pull requestu (při ignorování zakomentovaného textu) není prázdný. V
   případě, že je, ukončí běh se srozumitelnou chybou.

3. Skript naklonuje repozitář do samostatného adresáře a použije `base_branch`
   (master by default), a aplikuje na něj commity z aktuálního pull-requestu.
   Pokud není možné commity aplikovat čistě (existují konflikty), ukončí běh se
   srozumitelnou chybou.


4. Načte soubor `.munihub.yml` v aktuálním adresáři, který má formát:

    ```
    :test_script: rake test
    ```

5. Spustí skript konfigurovaný v `:test_script:`

6. Pokud skript doběhne úspěšně, vypíše text zadaný v bodě (2) - v sprintu 4
   napojíme tuto funkcionalitu na odeslání pull-requestu do vzdálené služby

