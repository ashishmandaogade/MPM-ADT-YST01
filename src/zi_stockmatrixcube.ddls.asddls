@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Stock Price & Value Cube'
@Metadata.ignorePropagatedAnnotations: true
@Analytics.dataCategory: #CUBE

define view entity ZI_StockMatrixCube
  as select from I_MaterialStock_2 as Stock

  left outer join I_Product as _Product
    on Stock.Material = _Product.Product

  left outer join I_ProductValuationBasic as _Valuation
    on  Stock.Material           = _Valuation.Product
    and Stock.Plant              = _Valuation.ValuationArea
    and _Valuation.ValuationType = ''

  left outer join I_Plant as _Plant
    on Stock.Plant = _Plant.Plant

  association [0..1] to I_ProductText as _ProductText
    on  Stock.Material        = _ProductText.Product
    and _ProductText.Language = $session.system_language

  association [0..1] to I_ProductTypeText as _ProdTypeTxt
    on  _Product.ProductType  = _ProdTypeTxt.ProductType
    and _ProdTypeTxt.Language = $session.system_language

  association [0..1] to zextwg_text as _ExtGroupText
    on  _Product.ExternalProductGroup = _ExtGroupText.extwg
    and _ExtGroupText.language        = $session.system_language

{
  // ==================== KEYS ====================
    @EndUserText.label: 'Product'
  key Stock.Material,

  key Stock.Plant,

  key Stock.StorageLocation,

  key Stock.Batch,

  // MaterialBaseUnit as KEY ensures each UOM (MT/TO/EA/PC)
  // gets its own separate row and its own separate total
  @EndUserText.label: 'Unit of Measure'
  key Stock.MaterialBaseUnit,

  // ==================== DIMENSION ATTRIBUTES ====================

  _ProductText.ProductName                as MaterialDescription,

  _Product.ProductType                    as MaterialType,

  _ProdTypeTxt.MaterialTypeName           as MaterialTypeDescription,

  @ObjectModel.text.element: ['ExternalGroupDescription']
    @EndUserText.label: 'Ext Product Grp'
  _Product.ExternalProductGroup           as ExternalGroup,
  
   @EndUserText.label: 'Ext Product Grp Description'
  _ExtGroupText.ewbez                     as ExternalGroupDescription,

  @ObjectModel.text.element: ['PlantDescription']
     @EndUserText.label: 'Plant Description'
  _Plant.PlantName                        as PlantDescription,

  _Valuation.Currency                     as CompanyCodeCurrency,

  // ==================== MEASURES ====================

  // cast to abap.quan(15,3) forces 3 decimal places
  // e.g. 135.560 not just 135 or 136
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  cast( Stock.MatlWrhsStkQtyInMatlBaseUnit as abap.quan(15,3) )
                                          as TotalStockQuantity,

//  @DefaultAggregation: #MAX
//  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//  _Valuation.MovingAveragePrice           as InventoryPrice,

//@DefaultAggregation: #SUM
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'

cast(
   
    cast(
        case
            when _Valuation.InventoryValuationProcedure = 'S'
            then _Valuation.StandardPrice

            when _Valuation.InventoryValuationProcedure = 'V'
            then _Valuation.MovingAveragePrice

            else _Valuation.MovingAveragePrice
        end
    as abap.dec(15,2) )
as abap.dec(23,2) ) as InventoryPrice,

//  @DefaultAggregation: #SUM
//  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//  cast(
//    cast( Stock.MatlWrhsStkQtyInMatlBaseUnit as abap.dec(15,3) )
//    *
//    cast( 
//     _Valuation.MovingAveragePrice as abap.dec(15,2) )
//  as abap.dec(23,2) )                     as TotalInventoryValue,
  
 @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  @DefaultAggregation: #SUM
  cast(
    cast( Stock.MatlWrhsStkQtyInMatlBaseUnit as abap.dec(15,3) )
    *
    cast(
      case _Valuation.InventoryValuationProcedure
        when 'S' then _Valuation.StandardPrice
        when 'V' then _Valuation.MovingAveragePrice
        else _Valuation.MovingAveragePrice
      end as abap.dec(15,2)
    )
  as abap.dec(23,2) ) as TotalInventoryValue,

  // ==================== ASSOCIATIONS ====================

  _ProductText,
  _ProdTypeTxt,
  _ExtGroupText
}
