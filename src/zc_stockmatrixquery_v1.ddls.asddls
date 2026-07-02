@AbapCatalog.sqlViewName: 'ZCSTOCKMATRX'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Matrix Report: Plant vs Material Total'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #CONSUMPTION

define view ZC_StockMatrixQuery_V1
  as select from ZI_StockMatrixCube
{
  /// --- 1. ROW DIMENSIONS ---
  @AnalyticsDetails.query.axis: #ROWS
  @AnalyticsDetails.query.totals: #SHOW 
  ExternalGroup,
  
  @AnalyticsDetails.query.axis: #ROWS
  ExternalGroupDescription,

  // Splits units so you don't get the '*' error
  @AnalyticsDetails.query.axis: #ROWS
  @AnalyticsDetails.query.totals: #SHOW 
  MaterialBaseUnit,

  @AnalyticsDetails.query.axis: #ROWS
  Material,
  
  @AnalyticsDetails.query.axis: #ROWS
  MaterialDescription,
  
  @AnalyticsDetails.query.axis: #ROWS
  MaterialType,
  
  @AnalyticsDetails.query.axis: #ROWS
  MaterialTypeDescription,
  
  @AnalyticsDetails.query.axis: #ROWS
  StorageLocation,
  
  @AnalyticsDetails.query.axis: #ROWS
  Batch,

  // --- 2. COLUMN DIMENSIONS (Top Pivot Level) ---
  @AnalyticsDetails.query.axis: #COLUMNS
  @AnalyticsDetails.query.totals: #SHOW 
  @ObjectModel.text.element: ['PlantDescription']
  Plant,
  
  PlantDescription,

  // --- 3. MEASURES (Side-by-Side under each Plant) ---
  // The order here dictates the order on the screen!
  
  @AnalyticsDetails.query.axis: #COLUMNS
  InventoryPrice,        // Moving Price comes first

  @AnalyticsDetails.query.axis: #COLUMNS
  TotalInventoryValue,   // Total Value comes second

  @AnalyticsDetails.query.axis: #COLUMNS
  TotalStockQuantity,    // Stock Qty comes third

  // --- 4. REFERENCE FIELDS ---
  CompanyCodeCurrency
}
