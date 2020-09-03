@AbapCatalog.sqlViewName: 'ZVI_TRAVEL_M_MY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Data model for Travel'

@UI: {
 headerInfo: { typeName: 'Travel', typeNamePlural: 'Travels', title: { type: #STANDARD, value: 'TravelID' } } }

@Search.searchable: true
define root view ZI_TRAVEL_M_MY

  as select from ztravel_my as Travel



  /* Associations */
  association [0..1] to /DMO/I_Agency   as _Agency   on $projection.agency_id = _Agency.AgencyID
  association [0..1] to /DMO/I_Customer as _Customer on $projection.customer_id = _Customer.CustomerID
  association [0..1] to I_Currency      as _Currency on $projection.currency_code = _Currency.Currency

{
      @UI.facet: [ { id:              'Travel',
                     purpose:         #STANDARD,
                     type:            #IDENTIFICATION_REFERENCE,
                     label:           'Travel',
                     position:        10 } ]

      @UI.hidden: true
  key mykey,
      @UI: {
           lineItem:       [ { position: 10, importance: #HIGH } ],
           identification: [ { position: 10, label: 'Travel ID [1,...,99999999]' } ] }
      @Search.defaultSearchElement: true
      travel_id,
      @UI: {
          lineItem:       [ { position: 20, importance: #HIGH } ],
          identification: [ { position: 20 } ],
          selectionField: [ { position: 20 } ] }
      @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Agency', element: 'AgencyID'  } }]

      @ObjectModel.text.element: ['AgencyName'] ----meaning?
      @Search.defaultSearchElement: true

      agency_id,
      @UI: {
       lineItem:       [ { position: 30, importance: #HIGH } ],
       identification: [ { position: 30 } ],
       selectionField: [ { position: 30 } ] }
      @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Customer', element: 'CustomerID'  } }]

      @ObjectModel.text.element: ['CustomerName']
      @Search.defaultSearchElement: true
      customer_id,

      @UI: {
       lineItem:       [ { position: 40, importance: #MEDIUM } ],
       identification: [ { position: 40 } ] }
      begin_date,
      @UI: {
      lineItem:       [ { position: 41, importance: #MEDIUM } ],
      identification: [ { position: 41 } ] }
      end_date,
      @Semantics.amount.currencyCode: 'currency_code'
      booking_fee,
      @UI: {
      lineItem:       [ { position: 50, importance: #MEDIUM } ],
      identification: [ { position: 50, label: 'Total Price' } ] }

      @Semantics.amount.currencyCode: 'currency_code'
      total_price,
      @Semantics.currencyCode: true
      currency_code,
      description,

      /*-- Admin data --*/
      @Semantics.user.createdBy: true
      created_by,
      @Semantics.systemDateTime.createdAt: true
      created_at,
      @Semantics.user.lastChangedBy: true
      last_changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at,
      @UI: {
      lineItem:       [ { position: 60, importance: #HIGH },
      { type: #FOR_ACTION, dataAction: 'Booking', label: 'Booking'}],
      identification: [{type:#FOR_ACTION, dataAction: 'Booking', label: 'Booking'}],

      selectionField: [ { position: 40 } ]  }
      booking,

      /* Public associations */

      _Agency,
      _Customer,
      _Currency
}



































//@AbapCatalog.sqlViewName: 'ZVI_TRAVEL_M_MY'
//@AbapCatalog.compiler.compareFilter: true
//@AccessControl.authorizationCheck: #CHECK
//@EndUserText.label: 'Data model for travel'
//define view ZI_TRAVEL_M_MY as select from ztravel_my {
//
////ztravel_my
//key client,
//key mykey,
//travel_id,
//agency_id,
//customer_id,
//begin_date,
//end_date,
//booking_fee,
//total_price,
//currency_code,
//description,
//created_by,
//created_at,
//last_changed_by,
//last_changed_at
//
//
//}
