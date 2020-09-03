CLASS zcl_my_travel_logic DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_my_travel_logic.


    CLASS-METHODS: get_instance RETURNING VALUE(ro_instance) TYPE REF TO zcl_my_travel_logic.

    CLASS-METHODS map_travel_cds_to_db

      IMPORTING is_i_travel      TYPE zi_travel_m_my

      RETURNING VALUE(rs_travel) TYPE zif_my_travel_logic=>ts_travel.


     METHODS create_travel    IMPORTING it_travel TYPE zif_my_travel_logic=>tt_travel.




  METHODS save.
  METHODS initialize.


  PROTECTED SECTION.
  PRIVATE SECTION.

    CLASS-DATA go_instance TYPE REF TO zcl_my_travel_logic.
ENDCLASS.



CLASS zcl_my_travel_logic IMPLEMENTATION.
  METHOD get_instance.


    go_instance = COND #( WHEN go_instance IS BOUND THEN go_instance ELSE NEW #( ) ).

    ro_instance = go_instance.

  ENDMETHOD.

  METHOD map_travel_cds_to_db.

    rs_travel = CORRESPONDING #(  is_i_travel MAPPING  agency_id = agency_id
                                                       begin_date = begin_date
                                                       booking = booking
                                                       booking_fee = booking_fee
                                                       created_at = created_at
                                                       created_by = created_by
                                                       currency_code = currency_code
                                                       customer_id = customer_id
                                                       description = description
                                                       end_date = end_date
                                                       last_changed_at = last_changed_at
                                                       last_changed_by = last_changed_by
                                                       mykey = mykey
                                                       total_price = total_price
                                                       travel_id = travel_id ).





  ENDMETHOD.

  METHOD create_travel.

        lcl_my_travel_buffer=>get_instance( )->buffer_travel_for_create( EXPORTING it_travel   = it_travel ).



  ENDMETHOD.

  METHOD save.


      lcl_my_travel_buffer=>get_instance( )->save( ).

    initialize( ).



  ENDMETHOD.

  METHOD initialize.

  ENDMETHOD.

ENDCLASS.
