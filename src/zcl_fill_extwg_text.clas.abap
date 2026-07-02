CLASS zcl_fill_extwg_text DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.



CLASS ZCL_FILL_EXTWG_TEXT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: lt_texts TYPE TABLE OF zextwg_text.


    DELETE FROM zextwg_text.      "#EC CI_NOWHERE


    lt_texts = VALUE #(
      ( language = 'E' extwg = '1000' ewbez = 'Cabasil' )
      ( language = 'E' extwg = '1100' ewbez = 'FeSiMg' )
      ( language = 'E' extwg = '1200' ewbez = 'Inoculant' )
      ( language = 'E' extwg = '1300' ewbez = 'Minaculant' )
      ( language = 'E' extwg = '1400' ewbez = 'LCA' )
      ( language = 'E' extwg = '1410' ewbez = 'Lustronite' )
      ( language = 'E' extwg = '1500' ewbez = 'Sandiron' )
      ( language = 'E' extwg = '1600' ewbez = 'Graphite' )
      ( language = 'E' extwg = '1700' ewbez = 'Others' )
      ( language = 'E' extwg = '1710' ewbez = 'Compact Wood Chips' )
      ( language = 'E' extwg = '1800' ewbez = 'CPC' )
      ( language = 'E' extwg = '1900' ewbez = 'Filters' )
      ( language = 'E' extwg = '2000' ewbez = 'Perlite' )
      ( language = 'E' extwg = '2100' ewbez = 'Raw Material' )
      ( language = 'E' extwg = '2101' ewbez = 'Impoterd Coal' )
      ( language = 'E' extwg = '2102' ewbez = 'Coking Coal' )
      ( language = 'E' extwg = '2103' ewbez = 'Anthracite Coal' )
      ( language = 'E' extwg = '2104' ewbez = 'Coaltar Pitch' )
      ( language = 'E' extwg = '2105' ewbez = 'Pitch Cocke' )
      ( language = 'E' extwg = '2106' ewbez = 'Sawdust' )
      ( language = 'E' extwg = '2107' ewbez = 'Bakedfines (BFR)' )
      ( language = 'E' extwg = '2108' ewbez = 'Graphite' )
      ( language = 'E' extwg = '2109' ewbez = 'Ferrosilicon' )
      ( language = 'E' extwg = '2110' ewbez = 'Ferrosilicon Barium' )
      ( language = 'E' extwg = '2111' ewbez = 'Ferrosilicon Stronci' )
      ( language = 'E' extwg = '2112' ewbez = 'CPC' )
      ( language = 'E' extwg = '2113' ewbez = 'Desulco' )
      ( language = 'E' extwg = '2114' ewbez = 'Bentonite' )
      ( language = 'E' extwg = '2115' ewbez = 'Lub Oil' )
      ( language = 'E' extwg = '2116' ewbez = 'Waste Cocke' )
      ( language = 'E' extwg = '2117' ewbez = 'Dust Supressing Agt.' )
      ( language = 'E' extwg = '2118' ewbez = 'Screen SFG' )
      ( language = 'E' extwg = '2119' ewbez = 'Scrap SFG' )
      ( language = 'E' extwg = '2120' ewbez = 'Fesi Others' )
      ( language = 'E' extwg = '2200' ewbez = 'Packing Materials' )
      ( language = 'E' extwg = '2300' ewbez = 'Stores & Spares' )
      ( language = 'E' extwg = '2400' ewbez = 'Diecote' )
      ( language = 'E' extwg = '2500' ewbez = 'Mincoat' )
      ( language = 'E' extwg = '2600' ewbez = 'Plumax' )
      ( language = 'E' extwg = '2700' ewbez = 'Refex' )
      ( language = 'E' extwg = '2800' ewbez = 'Ferro Alloys' )
      ( language = 'E' extwg = '2900' ewbez = 'Nodulant' )
      ( language = 'E' extwg = '3000' ewbez = 'Recarburizers' )
      ( language = 'E' extwg = '3100' ewbez = 'Resin' )
      ( language = 'E' extwg = '3200' ewbez = 'Sandiron' )
      ( language = 'E' extwg = '3300' ewbez = 'Die Dressing' )
      ( language = 'E' extwg = '3400' ewbez = 'Hydro base' )
      ( language = 'E' extwg = '3500' ewbez = 'Alcohol Base' )
      ( language = 'E' extwg = '3510' ewbez = 'Sanitizer' )
      ( language = 'E' extwg = '3600' ewbez = 'Inter -Mediates' )
      ( language = 'E' extwg = '3800' ewbez = 'Sleeve' )
      ( language = 'E' extwg = '3900' ewbez = 'Fesi Fines' )
      ( language = 'E' extwg = '4000' ewbez = 'Special Inoculant' )
      ( language = 'E' extwg = '4100' ewbez = 'Lubricant' )
      ( language = 'E' extwg = '4200' ewbez = 'Merchandise' )
      ( language = 'E' extwg = '4300' ewbez = 'Mould Powder' )
      ( language = 'E' extwg = '5000' ewbez = 'Machine' )
      ( language = 'E' extwg = '5001' ewbez = 'Consumable' )
      ( language = 'E' extwg = '5002' ewbez = 'Stores' )
      ( language = 'E' extwg = '5003' ewbez = 'Tools & Tackles' )
      ( language = 'E' extwg = '5004' ewbez = 'Asset' )
    ).

    " Insert the data into your custom database table
    INSERT zextwg_text FROM TABLE @lt_texts.

    IF sy-subrc = 0.
      out->write( 'Success: All External Group descriptions inserted into ZEXTWG_TEXT.' ).
    ELSE.
      out->write( 'Error: Could not insert data.' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
