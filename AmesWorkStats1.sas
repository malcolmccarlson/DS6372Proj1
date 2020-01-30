/*Import Data*/
proc import out=DataTable
	datafile="/Users/malco/Documents/MDS/MDS_6372_Applied_Statistics/ProjectDetails/CleanAmes2.csv" 
	dbms=CSV replace;
	Getnames=YES;
	Datarow=2;
	guessingrows=3000;
run;
proc print data = DataTable;run;

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
/selection=LASSO(stop=cv) CVMETHOD=RANDOM(20) stats=ADJRSQ;
store out=TrainModelLASSO;
run;

/* VIFs */
proc GLM  data=train plots=all;
model SalePriceLog = Hood ExteriorQual KitchQual BasemtQual GarageFin LotFrontage MSSubClass BsmtFinSF2 LowQualFinSF 
FenceQ PoolQ GarageC GarageQ FireplaceQ HmFunctional HeatingQ BsmtFinType1q BsmtFinType2q BsmtExposur BsmtCondQ ExterCondQ
BsmtHalfBath Fireplaces WoodDeckSF EnclosedPorch ScreenPorch PoolArea BsmtFullBath HalfBath KitchenAbvGr FullBath GarageCars MoSold
BedroomAbvGr  TotRmsAbvGrd OpenPorchSF BsmtUnfSF GarageArea BsmtFinSF1 OverallQual OverallCond
TotalBsmtSF GrLivArea YearBuilt YearRemodAdd YrSold LotArea _3SsnPorch _2ndFlrSF _1stFlrSF GarageYrBlt MasVnrArea GrLivAreaLog 
/solution clparm;
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
/selection=LARS(stop=cv) CVMETHOD=RANDOM(20) stats=ADJRSQ;
store out=TrainModelLARS;
run;

proc plm restore=TrainModelLARS;
score data=Test out=TestModelLARS
pred=Predicted lcl=Lower ucl=Upper;
run;

/* 2 way anova with OverallQual, OvarallCond */
proc glm data=DataTable;
	class SalePrice OverallQual;
	model SalePrice = OverallQual OVerallCond OverallQual*OverallCond;
	lsmeans SalePrice / pdiff=all adjust=tukey;
run;
