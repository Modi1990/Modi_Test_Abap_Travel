*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_my_travel_buffer DEFINITION FINAL CREATE PRIVATE.
  PUBLIC SECTION.

    DATA: mt_create_buffer_travel TYPE zif_my_travel_logic=>tt_travel.

    CLASS-METHODS: get_instance RETURNING VALUE(ro_instance) TYPE REF TO lcl_my_travel_buffer.

    METHODS buffer_travel_for_Create     IMPORTING it_travel TYPE zif_my_travel_logic=>tt_travel
                                         EXPORTING et_travel TYPE zif_my_travel_logic=>tt_travel.





    METHODS save.
    METHODS initialize.
  PRIVATE SECTION.

    CLASS-DATA go_instance TYPE REF TO lcl_my_travel_buffer.


ENDCLASS.


CLASS lcl_my_travel_buffer IMPLEMENTATION.


  METHOD get_instance.
    go_instance = COND #( WHEN go_instance IS BOUND THEN go_instance ELSE NEW #( ) ).
    ro_instance = go_instance.
  ENDMETHOD.


  METHOD buffer_travel_for_Create.


    CHECK it_travel IS NOT INITIAL.

*    SELECT FROM ztravel_my
*    FIELDS                             agency_id
*    FOR ALL ENTRIES IN                 @it_travel
*    WHERE                              agency_id = @it_travel-agency_id
*    INTO CORRESPONDING FIELDS OF TABLE @lt_purchasedocument_id.

    LOOP AT it_travel INTO DATA(ls_travel_create) ##INTO_OK.
      " Check Purchase Document number is initial or not
*      IF ls_travel_create-agency_id IS INITIAL.
*        "add exception to message class if purchase document ID is initial
*        APPEND NEW zcx_my_purchdoc_excptions( textid = zcx_my_purchdoc_excptions=>purchasedocintial  mv_purchasedocument = ls_purchdoc_create-purchasedocument )
*        TO et_messages.
*        initialize( ).
*        RETURN.
*      ENDIF.
*
*      " Check if the Purchase Document ID already Exists
*      IF line_exists( lt_purchasedocument_id[ purchasedocument = ls_purchdoc_create-purchasedocument ] ).
*        "add exception to message class if Purchase Do  cument ID exists
*        APPEND NEW zcx_my_purchdoc_excptions( textid = zcx_my_purchdoc_excptions=>purchasedocexists  mv_purchasedocument = ls_purchdoc_create-purchasedocument )
*        TO et_messages.
*        initialize( ).
*        RETURN.
*      ENDIF.
*
*      " Check in buffer table if the Purchase Document ID already exists or not
*      IF line_exists( mt_create_buffer_PurchDoc[ purchasedocument = ls_purchdoc_create-purchasedocument ] ).
*        "add exception to message class if Purchase Document ID exists in buffer table
*        APPEND NEW zcx_my_purchdoc_excptions( textid = zcx_my_purchdoc_excptions=>purchasedocexitsinbuffer  mv_purchasedocument = ls_purchdoc_create-purchasedocument )
*        TO et_messages.
*        initialize( ).
*        RETURN.
*      ENDIF.

      INSERT ls_travel_create INTO TABLE mt_create_buffer_travel.
    ENDLOOP.

    et_travel = mt_create_buffer_travel.
  ENDMETHOD.


  METHOD save.

  INSERT ztravel_my FROM TABLE @mt_create_buffer_travel.

ENDMETHOD.


METHOD initialize.

clear: mt_create_buffer_travel.

ENDMETHOD.
ENDCLASS.
