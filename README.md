# GoKart Action

Using this GitHub Action, scan your code with GoKart to finds vulnerabilities using the SSA (single static assignment) form of Go source code¹.

![GoKart Action Proof-of-Concept](https://user-images.githubusercontent.com/25837540/131348481-b57e230b-7472-4fe6-9599-aee2d09dd3e4.png)

## Usage

The workflow, usually declared in `.github/workflows/gokart.yaml` under your Go project repository, looks like:

```yaml
name: GoKart

on:
  push:
    branches: [ master, main ]
  pull_request:
    branches: [ master, main ]
  schedule:
    - cron: 0 0 * * *

env:
  GOKART_OUTPUT: "output.sarif"

jobs:
  gokart:
    name: GoKart scanner
    runs-on: ubuntu-latest
    permissions:
      security-events: write

    steps:
    - name: Checkout the code
      uses: actions/checkout@v2

    - name: Run GoKart
      uses: kitabisa/gokart-action@v1
      with:
        globalsTainted: true
        output: ${{ env.GOKART_OUTPUT }}

    - name: Upload GoKart results
      uses: github/codeql-action/upload-sarif@v1
      with:
        sarif_file: ${{ env.GOKART_OUTPUT }}
```

You can change the analysis base directory and/or analyzer config by using optional input like this:

```yaml
uses: kitabisa/gokart-action@v1
with:
  directory: "./path/to/go-project"
  input: "./.github/gokart-analyzers.yaml"
```

## Inputs

- `directory` - scan on a Go module in the directory **(default: `.`)**.
- `input` - input path to custom yml _(analyzer config)_ file.
- `output` - _**(Required)**_ file path to write findings output **(default: `results`)**.
- `globalsTainted` - marks global variables as dangerous.
<!-- - `remoteModule` - remote go module to scan.
- `debug` - outputs debug logs.
- `verbose` - outputs full trace of taint analysis. -->

## References

- [1] https://github.com/praetorian-inc/gokart#gokart---go-security-static-analysis
- https://www.praetorian.com/blog/introducing-gokart/

## License

The Dockerfile and associated scripts and documentation in this project are released under the MIT.

Container images built with this project include third party materials.