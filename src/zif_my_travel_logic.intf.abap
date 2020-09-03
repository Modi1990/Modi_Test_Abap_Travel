INTERFACE zif_my_travel_logic
  PUBLIC .




  TYPES tt_travel TYPE SORTED TABLE OF ztravel_my WITH UNIQUE KEY mykey .

  TYPES BEGIN OF ts_travel.

  INCLUDE TYPE ztravel_my.

  TYPES END OF ts_travel.

ENDINTERFACE.
