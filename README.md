# ML workflow example

The goal of this repository is to provide an example of an ML workflow, where we go through the following steps:

  1. Visualize and summarize the data.
  2. Fit and evaluate multiple models.
  3. Provide final evaluation of the selected model.
  4. Make predictions for new observations.
  
My objective is containerize the first and the last step of this process. Moreover, the first and third step should produce reports in some form (e.g. HTML or PDF).

## 1. Visualize and summarize the data

This can be done by running the following command from the root directory:

```bash
Rscript src/01-initial-exploration.R data/wage_model.csv --target=wage --out=out.pdf
```

## 2. Fit and evaluate multiple models

This step is performed in the notebook `src/02-prediction-model.ipynb`. At the moment, we only fit and evaluate one model.

## 3. Provide final evaluation of the selected model

This is currently done directly in the notebook `src/02-prediction-model.ipynb`.

## 4. Make predictions for new observations

This is done through an API built using [FastAPI](https://fastapi.tiangolo.com/). To start the API, run the following commands:

```bash
cd src
uvicorn 04-predict-newdata:app --reload
```

Then you can send HTTP requests using curl (from the root directory):

```bash
curl -X 'GET' \
  'http://127.0.0.1:8000/predict/path/FULL/PATH/TO/GH-REPOSITORY/data/wage_pred.csv' \
  -H 'accept: application/json'
```
