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

Alternatively, you can also use the containerized version of the API. First, build and start the container:

```bash
docker build -t predict -f predict.Dockerfile .
docker run -d -p 8000:8000 predict
```

Then you can send HTTP requests using `curl`. For example:


``` bash
JSON='{"year":{"0":2006},"age":{"0":18},"maritl":{"0":"1. Never Married"},"race":{"0":"1. White"},"education":{"0":"1. < HS Grad"},"region":{"0":"2. Middle Atlantic"},"jobclass":{"0":"1. Industrial"},"health":{"0":"1. <=Good"},"health_ins":{"0":"2. No"},"logwage":{"0":4.318063335},"wage":{"0":75.0431540174}}'

curl -X 'GET' \
  "http://0.0.0.0:8000/predict/json/$(echo $JSON |jq -sRr @uri)"

# {"data":"{\"year\":{\"0\":2006},\"age\":{\"0\":18},\"maritl\":{\"0\":\"1. Never Married\"},\"race\":{\"0\":\"1. White\"},\"education\":{\"0\":\"1. < HS Grad\"},\"region\":{\"0\":\"2. Middle Atlantic\"},\"jobclass\":{\"0\":\"1. Industrial\"},\"health\":{\"0\":\"1. <=Good\"},\"health_ins\":{\"0\":\"2. No\"},\"logwage\":{\"0\":4.318063335},\"wage\":{\"0\":75.0431540174}}\n","predictions":[4.104193364844004]}
```
