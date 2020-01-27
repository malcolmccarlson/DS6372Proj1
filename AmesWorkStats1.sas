/*Import Data*/;
proc import out=DataTable
	datafile="/Users/malco/Documents/MDS/MDS_6371_Statistics_Foundations/GrpProject/RealEstateData_AllData.csv" 
	dbms=CSV replace;
	Getnames=YES;
	Datarow=2;
	guessingrows=3000;
run;
proc print data=DataTable;run;

/*Impute Variables*/
data DataTable;
    set DataTable;
    if MasVnrArea="NA" then MasVnrArea=0;
    if GarageYrBlt='NA' then GarageYrBlt=YearBuilt;
    if GarageCars='NA' then GarageCars=0;
    if GarageArea='NA' then GarageArea=0; 
	if BsmtFinSF1='NA' then BsmtFinSF1=0;
	if BsmtFinSF2='NA' then BsmtFinSF2=0;
	if BsmtFullBath='NA' then BsmtFullBath=0;
	if BsmtHalfBath='NA' then BsmtHalfBath=0;
	if BsmtUnfSF='NA' then BsmtUnfSF=0;
	if TotalBsmtSF='NA' then TotalBsmtSF=0;
	if LotFrontage='NA' then LotFrontage=sqrt(LotArea);
    SalePriceLog = Log(SalePrice);
    GrLivAreaLog = Log(GrLivArea);
run;

/*Impute Neighborhood Variables*/
data DataTable;
    set DataTable;
	Hood = 0; 
	if Neighborhood in('MeadowV','IDOTRR','BrDale') then Hood=1;
	if Neighborhood in('BrkSide','Edwards','OldTown','Sawyer','Blueste','SWISU','NPkVill','NAmes','Mitchel') then Hood=2;
	if Neighborhood in('SawyerW','NWAmes','Gilbert','Blmngtn','CollgCr','Crawfor','ClearCr','Somerst','Veenker','Timber') then Hood=3;
	if Neighborhood in('StoneBr','NridgHt','NoRidge') then Hood=4;
Run; 

/*Impute ExterQual Variables*/
data DataTable;
    set DataTable;
	ExteriorQual = 0; 
	if ExterQual = 'Ex' then ExteriorQual =5; 
	Else if ExterQual = 'Gd' then ExteriorQual =4;
	Else if ExterQual = 'TA' then ExteriorQual =3;
	Else if ExterQual = 'FA' then ExteriorQual =2;
	Else if ExterQual = 'Po' then ExteriorQual =1;
	Else ExteriorQual =0;
Run; 

/*Impute KitchenQual Variables*/
data DataTable;
    set DataTable;
	KitchQual = 0; 
	if KitchenQual = 'Ex' then KitchQual =5; 
	Else if KitchenQual = 'Gd' then KitchQual =4;
	Else if KitchenQual = 'TA' then KitchQual =3;
	Else if KitchenQual = 'FA' then KitchQual =2;
	Else if KitchenQual = 'Po' then KitchQual =1;
	Else KitchQual =0;
Run; 

/*Impute BsmtQual Variables*/
data DataTable;
    set DataTable;
	BasemtQual = 0; 
	if BsmtQual = 'Ex' then BasemtQual =6; 
	Else if BsmtQual = 'Gd' then BasemtQual =5;
	Else if BsmtQual = 'TA' then BasemtQual =4;
	Else if BsmtQual = 'FA' then BasemtQual =3;
	Else if BsmtQual = 'Po' then BasemtQual =2;
	Else if BsmtQual = 'NA' then BasemtQual =1;
	Else BasemtQual =0;
Run; 

/*Impute GarageFinish Variables*/
data DataTable;
    set DataTable;
	GarageFin = 0; 
	if GarageFinish = 'Fin' then GarageFin =4; 
	Else if GarageFinish = 'RFn' then GarageFin =3;
	Else if GarageFinish = 'Unf' then GarageFin =2;
	Else if GarageFinish = 'NA' then GarageFin =1;
	Else GarageFin =0;
Run; 

/*Impute Fence Variables*/
data DataTable;
    set DataTable;
	FenceQ = 0; 
	if Fence = 'GdPrv' then FenceQ=5; 
	Else if Fence= 'MnPrv' then FenceQ=4;
	Else if Fence= 'GdWo' then FenceQ=3;
	Else if Fence= 'MnWw' then FenceQ=2;
	Else if Fence= 'NA' then FenceQ=1;
	Else FenceQ=0;
Run; 

/*Impute PoolQC Variables*/
data DataTable;
    set DataTable;
	PoolQ = 0; 
	if PoolQC= 'Ex' then PoolQ=5; 
	Else if PoolQC= 'Gd' then PoolQ=4;
	Else if PoolQC= 'TA' then PoolQ=3;
	Else if PoolQC= 'Fa' then PoolQ=2;
	Else if PoolQC= 'NA' then PoolQ=1;
	Else PoolQ=0;
Run; 

/*Impute GarageCond Variables*/
data DataTable;
    set DataTable;
	GarageC = 0; 
	if GarageCond= 'Ex' then GarageC=6; 
	Else if GarageCond= 'Gd' then GarageC=5;
	Else if GarageCond= 'TA' then GarageC=4;
	Else if GarageCond= 'FA' then GarageC=3;
	Else if GarageCond= 'Po' then GarageC=2;
	Else if GarageCond= 'NA' then GarageC=1;
	Else GarageC=0;
Run; 

/*Impute GarageQual Variables*/
data DataTable;
    set DataTable;
	GarageQ = 0; 
	if GarageQual= 'Ex' then GarageQ=6; 
	Else if GarageQual= 'Gd' then GarageQ=5;
	Else if GarageQual= 'TA' then GarageQ=4;
	Else if GarageQual= 'FA' then GarageQ=3;
	Else if GarageQual= 'Po' then GarageQ=2;
	Else if GarageQual= 'NA' then GarageQ=1;
	Else GarageQ=0;
Run; 

/*Impute FireplaceQu Variables*/
data DataTable;
    set DataTable;
	FireplaceQ = 0; 
	if FireplaceQu= 'Ex' then FireplaceQ=6; 
	Else if FireplaceQu= 'Gd' then FireplaceQ=5;
	Else if FireplaceQu= 'TA' then FireplaceQ=4;
	Else if FireplaceQu= 'FA' then FireplaceQ=3;
	Else if FireplaceQu= 'Po' then FireplaceQ=2;
	Else if FireplaceQu= 'NA' then FireplaceQ=1;
	Else FireplaceQ=0;
Run; 

/*Impute Functional Variables*/
data DataTable;
    set DataTable;
	HmFunctional = 0; 
	if Functional= 'Typ' then HmFunctional=8; 
	Else if Functional= 'Min1' then HmFunctional=7;
	Else if Functional= 'Min2' then HmFunctional=6;
	Else if Functional= 'Mod' then HmFunctional=5;
	Else if Functional= 'Maj1' then HmFunctional=4;
	Else if Functional= 'Maj2' then HmFunctional=3;
	Else if Functional= 'Sev' then HmFunctional=2;
	Else if Functional= 'Sal' then HmFunctional=1;
	Else HmFunctional=0;
Run; 

/*Impute HeatingQC Variables*/
data DataTable;
    set DataTable;
	HeatingQ = 0; 
	if HeatingQC = 'Ex' then HeatingQ=5; 
	Else if HeatingQC= 'Gd' then HeatingQ=4;
	Else if HeatingQC= 'TA' then HeatingQ=3;
	Else if HeatingQC= 'FA' then HeatingQ=2;
	Else if HeatingQC= 'Po' then HeatingQ=1;
	Else HeatingQ=0;
Run; 

/*Impute BsmtFinType1 Variables*/
data DataTable;
    set DataTable;
	BsmtFinType1q = 0; 
	if BsmtFinType1= 'GLQ' then BsmtFinType1q=7; 
	Else if BsmtFinType1= 'ALQ' then BsmtFinType1q=6;
	Else if BsmtFinType1= 'BLQ' then BsmtFinType1q=5;
	Else if BsmtFinType1= 'Rec' then BsmtFinType1q=4;
	Else if BsmtFinType1= 'LwQ' then BsmtFinType1q=3;
	Else if BsmtFinType1= 'Unf' then BsmtFinType1q=2;
	Else if BsmtFinType1= 'NA' then BsmtFinType1q=1;
	Else BsmtFinType1q=0;
Run; 

/*Impute BsmtFinType2 Variables*/
data DataTable;
    set DataTable;
	BsmtFinType2q = 0; 
	if BsmtFinType2= 'GLQ' then BsmtFinType2q=7; 
	Else if BsmtFinType2= 'ALQ' then BsmtFinType2q=6;
	Else if BsmtFinType2= 'BLQ' then BsmtFinType2q=5;
	Else if BsmtFinType2= 'Rec' then BsmtFinType2q=4;
	Else if BsmtFinType2= 'LwQ' then BsmtFinType2q=3;
	Else if BsmtFinType2= 'Unf' then BsmtFinType2q=2;
	Else if BsmtFinType2= 'NA' then BsmtFinType2q=1;
	Else BsmtFinType2q=0;
Run; 

/*Impute BsmtExposure Variables*/
data DataTable;
    set DataTable;
	BsmtExposur = 0; 
	if BsmtExposure = 'Gd' then BsmtExposur=5; 
	Else if BsmtExposure= 'Av' then BsmtExposur=4;
	Else if BsmtExposure= 'Mn' then BsmtExposur=3;
	Else if BsmtExposure= 'No' then BsmtExposur=2;
	Else if BsmtExposure= 'NA' then BsmtExposur=1;
	Else BsmtExposur=0;
Run; 

/*Impute BsmtCond Variables*/
data DataTable;
    set DataTable;
	BsmtCondQ = 0; 
	if BsmtCond= 'Ex' then BsmtCondQ=6; 
	Else if BsmtCond= 'Gd' then BsmtCondQ=5;
	Else if BsmtCond= 'TA' then BsmtCondQ=4;
	Else if BsmtCond= 'FA' then BsmtCondQ=3;
	Else if BsmtCond= 'Po' then BsmtCondQ=2;
	Else if BsmtCond= 'NA' then BsmtCondQ=1;
	Else BsmtCond=0;
Run; 

/*Impute ExterCond Variables*/
data DataTable;
    set DataTable;
	ExterCondQ = 0; 
	if ExterCond= 'Ex' then ExterCondQ=6; 
	Else if ExterCond= 'Gd' then ExterCondQ=5;
	Else if ExterCond= 'TA' then ExterCondQ=4;
	Else if ExterCond= 'FA' then ExterCondQ=3;
	Else if ExterCond= 'Po' then ExterCondQ=2;
	Else if ExterCond= 'NA' then ExterCondQ=1;
	Else ExterCond=0;
Run; 
proc print data=DataTable;run;

proc export data=DataTable dbms=csv
outfile="C:\Users\malco\Documents\MDS\MDS_6372_Applied_Statistics\ProjectDetails\CleanAmes.csv"
replace;
run;

/*Change Character Columns to Numeric*/
data DataTable;
set DataTable;
BsmtFinSF1a = Input(BsmtFinSF1,BEST12.);
BsmtFinSF2a = Input(BsmtFinSF2,BEST12.);
BsmtFullBatha = Input(BsmtFullBath,BEST12.);
BsmtHalfBatha = Input(BsmtHalfBath,BEST12.);
BsmtUnfSFa = Input(BsmtUnfSF,BEST12.);
GarageAreaa = Input(GarageArea,BEST12.);
GarageCarsa = Input(GarageCars,BEST12.);
GarageYrBlta = Input(GarageYrBlt,BEST12.);
MasVnrAreaa = Input(MasVnrArea,BEST12.);
TotalBsmtSFa = Input(TotalBsmtSF,BEST12.);
LotFrontageA = Input(LotFrontage,BEST12.);
  drop LotFrontage BsmtFinSF1	BsmtFinSF2	BsmtFullBath	BsmtHalfBath	BsmtUnfSF	GarageArea	GarageCars	GarageYrBlt	MasVnrArea	TotalBsmtSF;
  rename LotFrontageA=LotFrontage BsmtFinSF1a=BsmtFinSF1	BsmtFinSF2a=BsmtFinSF2	BsmtFullBatha=BsmtFullBath	BsmtHalfBatha=BsmtHalfBath	BsmtUnfSFa=BsmtUnfSF	GarageAreaa=GarageArea	GarageCarsa=GarageCars	GarageYrBlta=GarageYrBlt	MasVnrAreaa=MasVnrArea	TotalBsmtSFa=TotalBsmtSF;
run;

proc export data=DataTable dbms=csv
outfile="C:\Users\malco\Documents\MDS\MDS_6372_Applied_Statistics\ProjectDetails\CleanAmes2.csv"
replace;
run;

/*Create Train Table*/
Data train;
set DataTable (Keep=Id Hood ExteriorQual KitchQual BasemtQual GarageFin LotFrontage MSSubClass SalePrice BsmtFinSF2 LowQualFinSF 
FenceQ PoolQ GarageC GarageQ FireplaceQ HmFunctional HeatingQ BsmtFinType1q BsmtFinType2q BsmtExposur BsmtCondQ ExterCondQ
BsmtHalfBath Fireplaces WoodDeckSF EnclosedPorch ScreenPorch PoolArea BsmtFullBath HalfBath KitchenAbvGr FullBath GarageCars MoSold
BedroomAbvGr  TotRmsAbvGrd OpenPorchSF BsmtUnfSF GarageArea BsmtFinSF1 OverallQual OverallCond
TotalBsmtSF GrLivArea YearBuilt YearRemodAdd YrSold LotArea _3SsnPorch _2ndFlrSF _1stFlrSF GarageYrBlt MasVnrArea GrLivAreaLog SalePriceLog); 
where SalePrice > 0;
Run;
/*Reduce Range*/
data Train;
set Train;
if (GrLivArea <4500 and SalePrice > 0) then output;
run;

/*Create Test Table*/
Data test;
set Datatable (Keep=Id Hood ExteriorQual KitchQual BasemtQual GarageFin LotFrontage MSSubClass BsmtFinSF2 LowQualFinSF 
FenceQ PoolQ GarageC GarageQ FireplaceQ HmFunctional HeatingQ BsmtFinType1q BsmtFinType2q BsmtExposur BsmtCondQ ExterCondQ
BsmtHalfBath Fireplaces WoodDeckSF EnclosedPorch ScreenPorch PoolArea BsmtFullBath HalfBath KitchenAbvGr FullBath GarageCars MoSold
BedroomAbvGr  TotRmsAbvGrd OpenPorchSF BsmtUnfSF GarageArea BsmtFinSF1 OverallQual OverallCond
TotalBsmtSF GrLivArea YearBuilt YearRemodAdd YrSold LotArea _3SsnPorch _2ndFlrSF _1stFlrSF GarageYrBlt MasVnrArea GrLivAreaLog SalePrice);
where SalePrice is null;
Run;


/*View Data*/
proc contents data=train; run;
proc contents data=Test; run;
proc print data=train (obs=200);run;

*///////////////////////////////////////////Forward Selection Model  *//////////////////////////////////////////////;
proc GLMSELECT  data=train plots=all;
model SalePriceLog = Hood ExteriorQual KitchQual BasemtQual GarageFin LotFrontage MSSubClass BsmtFinSF2 LowQualFinSF 
FenceQ PoolQ GarageC GarageQ FireplaceQ HmFunctional HeatingQ BsmtFinType1q BsmtFinType2q BsmtExposur BsmtCondQ ExterCondQ
BsmtHalfBath Fireplaces WoodDeckSF EnclosedPorch ScreenPorch PoolArea BsmtFullBath HalfBath KitchenAbvGr FullBath GarageCars MoSold
BedroomAbvGr  TotRmsAbvGrd OpenPorchSF BsmtUnfSF GarageArea BsmtFinSF1 OverallQual OverallCond
TotalBsmtSF GrLivArea YearBuilt YearRemodAdd YrSold LotArea _3SsnPorch _2ndFlrSF _1stFlrSF GarageYrBlt MasVnrArea GrLivAreaLog 
/selection=forward(stop=cv) CVMETHOD=RANDOM(5) stats=ADJRSQ;
store out=TrainModelFW;
run;

/*Score Data, create predicted values for Forward Model*/
proc plm restore=TrainModelFW;
score data=Test out=TestModelFW
 pred=Predicted lcl=Lower ucl=Upper;
 run;

data ExportKaggleFW;
	set TestModelFW (keep=ID Predicted);
	psale = exp(Predicted);
	SalePrice = psale;
  	drop psale Predicted;
run;

proc print data=ExportKaggleFW (obs=200);run;

*///////////////////////////////////////////Backward Selection Model  *//////////////////////////////////////////////;
proc GLMSELECT  data=train plots=all;
model SalePriceLog = Hood ExteriorQual KitchQual BasemtQual GarageFin LotFrontage MSSubClass BsmtFinSF2 LowQualFinSF 
FenceQ PoolQ GarageC GarageQ FireplaceQ HmFunctional HeatingQ BsmtFinType1q BsmtFinType2q BsmtExposur BsmtCondQ ExterCondQ
BsmtHalfBath Fireplaces WoodDeckSF EnclosedPorch ScreenPorch PoolArea BsmtFullBath HalfBath KitchenAbvGr FullBath GarageCars MoSold
BedroomAbvGr  TotRmsAbvGrd OpenPorchSF BsmtUnfSF GarageArea BsmtFinSF1 OverallQual OverallCond
TotalBsmtSF GrLivArea YearBuilt YearRemodAdd YrSold LotArea _3SsnPorch _2ndFlrSF _1stFlrSF GarageYrBlt MasVnrArea GrLivAreaLog 
/selection=backward(stop=cv) CVMETHOD=RANDOM(5) stats=ADJRSQ;
store out=TrainModelBW;
run;

/*Score Data, create predicted values for Forward Model*/
proc plm restore=TrainModelBW;
score data=Test out=TestModelBW
 pred=Predicted lcl=Lower ucl=Upper;
 run;

data ExportKaggleBW;
	set TestModelBW (keep=ID Predicted);
	psale = exp(Predicted);
	SalePrice = psale;
  	drop psale Predicted;
run;

proc print data=ExportKaggleBW (obs=200);run;

*///////////////////////////////////////////Stepwise Selection Model  *//////////////////////////////////////////////;
proc GLMSELECT  data=train plots=all;
model SalePriceLog = Hood ExteriorQual KitchQual BasemtQual GarageFin LotFrontage MSSubClass BsmtFinSF2 LowQualFinSF 
FenceQ PoolQ GarageC GarageQ FireplaceQ HmFunctional HeatingQ BsmtFinType1q BsmtFinType2q BsmtExposur BsmtCondQ ExterCondQ
BsmtHalfBath Fireplaces WoodDeckSF EnclosedPorch ScreenPorch PoolArea BsmtFullBath HalfBath KitchenAbvGr FullBath GarageCars MoSold
BedroomAbvGr  TotRmsAbvGrd OpenPorchSF BsmtUnfSF GarageArea BsmtFinSF1 OverallQual OverallCond
TotalBsmtSF GrLivArea YearBuilt YearRemodAdd YrSold LotArea _3SsnPorch _2ndFlrSF _1stFlrSF GarageYrBlt MasVnrArea GrLivAreaLog 
/selection=stepwise(stop=cv) CVMETHOD=RANDOM(5) stats=ADJRSQ;
store out=TrainModelSW;
run;

/*Score Data, create predicted values for Forward Model*/
proc plm restore=TrainModelSW;
score data=Test out=TestModelSW
 pred=Predicted lcl=Lower ucl=Upper;
 run;

*///////////////////////////////////////////LASSO Model  *//////////////////////////////////////////////;
proc GLMSELECT  data=train plots=all;
model SalePriceLog = Hood ExteriorQual KitchQual BasemtQual GarageFin LotFrontage MSSubClass BsmtFinSF2 LowQualFinSF 
FenceQ PoolQ GarageC GarageQ FireplaceQ HmFunctional HeatingQ BsmtFinType1q BsmtFinType2q BsmtExposur BsmtCondQ ExterCondQ
BsmtHalfBath Fireplaces WoodDeckSF EnclosedPorch ScreenPorch PoolArea BsmtFullBath HalfBath KitchenAbvGr FullBath GarageCars MoSold
BedroomAbvGr  TotRmsAbvGrd OpenPorchSF BsmtUnfSF GarageArea BsmtFinSF1 OverallQual OverallCond
TotalBsmtSF GrLivArea YearBuilt YearRemodAdd YrSold LotArea _3SsnPorch _2ndFlrSF _1stFlrSF GarageYrBlt MasVnrArea GrLivAreaLog 
/selection=LASSO stats=ADJRSQ;
store out=TrainModelLASSO;
run;

proc plm restore=TrainModelLASSO;
score data=Test out=TestModelLASSO
 pred=Predicted lcl=Lower ucl=Upper;
 run;

*///////////////////////////////////////////LARS Model  *//////////////////////////////////////////////;
proc GLMSELECT  data=train plots=all;
model SalePriceLog = Hood ExteriorQual KitchQual BasemtQual GarageFin LotFrontage MSSubClass BsmtFinSF2 LowQualFinSF 
FenceQ PoolQ GarageC GarageQ FireplaceQ HmFunctional HeatingQ BsmtFinType1q BsmtFinType2q BsmtExposur BsmtCondQ ExterCondQ
BsmtHalfBath Fireplaces WoodDeckSF EnclosedPorch ScreenPorch PoolArea BsmtFullBath HalfBath KitchenAbvGr FullBath GarageCars MoSold
BedroomAbvGr  TotRmsAbvGrd OpenPorchSF BsmtUnfSF GarageArea BsmtFinSF1 OverallQual OverallCond
TotalBsmtSF GrLivArea YearBuilt YearRemodAdd YrSold LotArea _3SsnPorch _2ndFlrSF _1stFlrSF GarageYrBlt MasVnrArea GrLivAreaLog 
/selection=LARS stats=ADJRSQ;
store out=TrainModelLARS;
run;

proc plm restore=TrainModelLARS;
score data=Test out=TestModelLARS
pred=Predicted lcl=Lower ucl=Upper;
run;
