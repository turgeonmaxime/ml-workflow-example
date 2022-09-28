from flask import Flask, request

import pandas as pd
from joblib import load

app = Flask(__name__)

column_trans = load('artifacts/column_trans.joblib')
final_regr = load('artifacts/final_regr.joblib')

@app.route("/")
def hello_world():
	return "<p>Hello, World!</p>"

# Not sure how to make this one secure...
# @app.get("/predict/path/{file_path:path}")
# def predict_from_file(file_path: str):
# 	df = pd.read_csv(file_path)
# 	X = column_trans.transform(df)
# 	preds = final_regr.predict(X)
# 	return {"file_path": file_path, "predictions": preds.tolist()}

@app.post("/prediction")
def predict():
	json = request.get_json()
	df = pd.read_json(json)
	X = column_trans.transform(df)
	preds = final_regr.predict(X)
	return {"data": json, "predictions": preds.tolist()}

@app.route("/model/transform")
def get_transform_info():
	return(str(column_trans))

@app.route("/model/regression")
def get_model_info():
	return(str(final_regr))
