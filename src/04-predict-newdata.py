from fastapi import FastAPI

import pandas as pd
from joblib import load

app = FastAPI()

# column_trans = load('../artifacts/column_trans.joblib')
# final_regr = load('../artifacts/final_regr.joblib')
column_trans = load('artifacts/column_trans.joblib')
final_regr = load('artifacts/final_regr.joblib')

@app.get("/predict/path/{file_path:path}")
def predict_from_file(file_path: str):
	df = pd.read_csv(file_path)
	X = column_trans.transform(df)
	preds = final_regr.predict(X)
	return {"file_path": file_path, "predictions": preds.tolist()}

@app.get("/predict/json/{json}")
def predict_from_json(json: str):
	df = pd.read_json(json)
	X = column_trans.transform(df)
	preds = final_regr.predict(X)
	return {"data": json, "predictions": preds.tolist()}

@app.get("/model/transform")
def get_transform_info():
	return(str(column_trans))

@app.get("/model/regression")
def get_transform_info():
	return(str(final_regr))