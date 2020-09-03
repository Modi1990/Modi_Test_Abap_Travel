CLASS zcl_generate_travel_data_my DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_generate_travel_data_my IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA:itab TYPE TABLE OF ztravel_my.

*   read current timestamp
    GET TIME STAMP FIELD DATA(zv_tsl).

*   fill internal travel table (itab)
    itab = VALUE #(
  ( mykey = '02D5290E594C1EDA93815057FD946624' travel_id = '00000022' agency_id = '070001' customer_id = '000077' begin_date = '20190624' end_date = '20190628' booking_fee = '60.00' total_price =  '750.00' currency_code = 'USD'
    description = 'mv'  created_by = sy-uname created_at = '20190612133945.5960060' last_changed_by = 'MUSTERFRAU' last_changed_at = sy-datum booking ='NO' )
  ( mykey = '02D5290E594C1EDA93815C50CD7AE62A' travel_id = '00000106' agency_id = '070005' customer_id = '000005' begin_date = sy-datum end_date = '20190716' booking_fee = '17.00' total_price = '650.00' currency_code = 'AFN'
    description = 'Enter your comments here'  created_by = sy-uname created_at = '20190613111129.2391370' last_changed_by = 'MUSTERMANN' last_changed_at = '20190711140753.1472620' booking = 'NO' )
  ( mykey = '02D5290E594C1EDA93858EED2DA2EB0B' travel_id = '00000103' agency_id = '070010' customer_id = '000011' begin_date = '20190610' end_date = '20190714' booking_fee = '17.00' total_price = '800.00' currency_code = 'AFN'
    description = 'Enter your comments here'  created_by = sy-uname created_at = '20190613105654.4296640' last_changed_by = 'MUSTERFRAU' last_changed_at = '20190613111041.2251330' booking = 'NO' )
  ).

*   delete existing entries in the database table
    DELETE FROM ztravel_my.

*   insert the new table entries
    INSERT ztravel_my FROM TABLE @itab.

    SELECT COUNT( * ) FROM ztravel_my INTO @DATA(lv_count).
    out->write( 'recourd of our DB are     =   ' && lv_count  ).
*   check the result
    SELECT * FROM ztravel_my INTO TABLE @itab.
    out->write( sy-dbcnt ).
    out->write( 'Travel data inserted successfully!').

  ENDMETHOD.


ENDCLASS.





