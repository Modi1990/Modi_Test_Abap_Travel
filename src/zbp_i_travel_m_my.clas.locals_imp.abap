CLASS lhc_travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE travel.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE travel.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE travel.

    METHODS read FOR READ
      IMPORTING keys FOR READ travel RESULT result.

    METHODS Booking FOR MODIFY
      IMPORTING keys FOR ACTION travel~Booking RESULT result.

    DATA: it_travel_create TYPE TABLE OF  ztravel_my.


ENDCLASS.

CLASS lhc_travel IMPLEMENTATION.

  METHOD create.

    DATA: ls_travel TYPE ztravel_my,
          lt_travel TYPE zif_my_travel_logic=>tt_travel.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_travel_create>).

      CLEAR     ls_travel.

      ls_travel = CORRESPONDING #( zcl_my_travel_logic=>get_instance(  )->map_travel_cds_to_db( CORRESPONDING #( <fs_travel_create> ) ) ).



      GET TIME STAMP FIELD ls_travel-created_at.
      GET TIME STAMP FIELD ls_travel-last_changed_at.
      ls_travel-created_by = sy-uname.
      ls_travel-last_changed_by = sy-uname.

      APPEND ls_travel TO it_travel_create.
    ENDLOOP.


    zcl_my_travel_logic=>get_instance( )->create_travel( EXPORTING it_travel = lt_travel ).




  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD Booking.

    LOOP AT keys INTO DATA(ls_booking).




      IF ls_booking-%cid_ref = 'NO'.

      ENDIF.
    ENDLOOP.


  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI_TRAVEL_M_MY DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS check_before_save REDEFINITION.

    METHODS finalize          REDEFINITION.

    METHODS save              REDEFINITION.
  PRIVATE SECTION.
*    DATA it_travel_create LIKE LINE OF zi_tr.

ENDCLASS.

CLASS lsc_ZI_TRAVEL_M_MY IMPLEMENTATION.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD finalize.
  ENDMETHOD.

  METHOD save.

    zcl_my_travel_logic=>get_instance( )->save( ).

  ENDMETHOD.

ENDCLASS.
