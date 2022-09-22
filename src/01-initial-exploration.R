# Initial exploration of the data----
'Automated initial data exploration.

Usage:
  02-initial-exploration.R <infile> --target=NAME [--out=FILE]
  02-initial-exploration.R (-h | --help)

Options:
  -h --help      Show this screen.
  --target=NAME  Name of target variable.
  --out=FILE     Path to output [default: out.pdf].

' -> doc

library(docopt)
args <- docopt(doc)
###################
library(readr)
library(stringr)
library(cli)
library(quarto)

# We stop early if:
#   - input file doesn't exist or isn't a CSV file
#   - target variable is not one of the columns
#   - output file extension is not PDF or HTML
if (!file.exists(args$infile) || 
    !str_detect(args$infile, "csv$")) {
    cli_abort("Input file doesn't exist or is not a csv file.")
}

if (!str_detect(args$out, regex("(html|pdf)$",
                                ignore_case = TRUE))) {
    cli_abort("Output file extension should be pdf or html.")
}
file_ext <- str_extract(args$out, regex("(html|pdf)$", ignore_case = TRUE)) |> 
    str_to_lower()

data <- read_csv(args$infile)

if (!args$target %in% names(data)) {
    cli_abort(paste("Supplied target name does not appear", 
                    "as a column name of the input file."))
}

# Render document----
tmp_dir <- tempdir()
Sys.setenv(REPORT_INFILE = paste0(tmp_dir, "/data.csv"),
           REPORT_TARGET = args$target)

system2("cp", c(args$infile, Sys.getenv("REPORT_INFILE")))
system2("cp", c("inst/template/initial_data_exploration.qmd",
                paste0(tmp_dir, "/report.qmd")))

quarto::quarto_render(paste0(tmp_dir, "/report.qmd"),
                      output_format = file_ext, # output_file = args$out,
                      pandoc_args = c("--embed-resources", "--standalone"))

system2("mv", c(paste0(tmp_dir, "/report.", file_ext), args$out))
