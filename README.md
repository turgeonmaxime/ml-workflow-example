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
Rscript src/02-initial-exploration.R data/wage_model.csv --target=wage --out=out.pdf
```

At the moment, HTML output causes issues because of (what I believe is) a bug in the `quarto` R package.
