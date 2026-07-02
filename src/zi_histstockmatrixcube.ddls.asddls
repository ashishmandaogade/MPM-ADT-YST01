@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Historical Material Stock Cube'
@Metadata.ignorePropagatedAnnotations: true
@Analytics.dataCategory: #CUBE

define view entity ZI_HistStockMatrixCube
  with parameters
    @Environment.systemField: #SYSTEM_DATE
    @EndUserText.label: 'Stock As Of Date'
    P_KeyDate : vdm_v_key_date
    
  as select from I_MaterialStock_2 as Stock
  
  left outer join I_Product as _Product on Stock.Material = _Product.Product
  
  left outer join I_ProductValuationBasic as _Valuation on Stock.Material = _Valuation.Product
                                                       and Stock.Plant = _Valuation.ValuationArea
                                                       and _Valuation.ValuationType = ''
                                                       
  left outer join I_Plant as _Plant on Stock.Plant = _Plant.Plant
  
  association [0..1] to I_ProductText as _ProductText on Stock.Material = _ProductText.Product
                                                     and _ProductText.Language = $session.system_language
                                                     
  association [0..1] to I_ProductTypeText as _ProdTypeTxt on _Product.ProductType = _ProdTypeTxt.ProductType
                                                         and _ProdTypeTxt.Language = $session.system_language

  // Reading your new Custom Table directly
  association [0..1] to zextwg_text as _ExtGroupText on _Product.ExternalProductGroup = _ExtGroupText.extwg
                                                    and _ExtGroupText.language = $session.system_language
{
  key Stock.Material,
  
  @ObjectModel.text.element: ['PlantDescription']
  key Stock.Plant,
  
  key Stock.StorageLocation,
  key Stock.Batch,
  
  Stock.MaterialBaseUnit,
  
  _ProductText.ProductName as MaterialDescription,
  _Product.ProductType as MaterialType,
  _ProdTypeTxt.MaterialTypeName as MaterialTypeDescription,
  
  // External Group mapping to your custom text table
  @ObjectModel.text.element: ['ExternalGroupDescription']
  _Product.ExternalProductGroup as ExternalGroup,
  _ExtGroupText.ewbez as ExternalGroupDescription,
  
  _Plant.PlantName as PlantDescription,
  
  _Valuation.Currency as CompanyCodeCurrency,
  
  @DefaultAggregation: #MAX
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  _Valuation.MovingAveragePrice as InventoryPrice,
  
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  Stock.MatlWrhsStkQtyInMatlBaseUnit as TotalStockQuantity,
  
  @DefaultAggregation: #SUM
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(
    cast( Stock.MatlWrhsStkQtyInMatlBaseUnit as abap.dec(15,3) ) * cast( _Valuation.MovingAveragePrice as abap.dec(15,2) )
  as abap.dec(23,2) ) as TotalInventoryValue,
  
  _ProductText,
  _ProdTypeTxt,
  _ExtGroupText
}
