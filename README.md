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

This is done through an API built using [Flask](https://flask.palletsprojects.com/). To start the API, run the following commands:

```bash
cd src
flask --app 04-setup-predict-api run
```

Then you can send HTTP requests using the `requests` module (from the root directory):

```python
import requests
import pandas as pd

df = pd.read_csv('data/wage_pred.csv')

response = requests.post('http://127.0.0.1:5000/prediction', 
                         json = df[0:5].to_json())
response.json()['predictions']
```

Alternatively, you can also use the containerized version of the API. First, build and start the container:

```bash
docker build -t predict -f predict.Dockerfile .
docker run -d -p 5000:5000 predict
```

The same python code as above can then be used to query the API.

For a full script which takes in a set of new data in CSV file, separates into chunks, and gets predictions for each chunk, see `src/04-script-predict-newdata.py`.
