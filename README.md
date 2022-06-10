## Project Idea
#### NB: State diagram uses three state variables but can be generalized to any number of state variables
![alt text](./project/state_diag.PNG?raw=true)

## Repository Structure
* The `peck` directory contains a parser that transforms a Solidity contract into an intermediate representation (IR), and derives Datalog facts that encode the contract’s IR. You must not edit any files in this folder..
* The `project` directory contains the code template for your project. Technical details on the IR and its representation in Datalog can be found in `project/README-IR.md`. The `project/test_contracts` directory contains example test contracts with annotated ground truth in comments. The `project/analyze.dl` and `project/analyze.py` are the main source files for the analysis.

## Setup Instructions
The project requires executables `python 3.9`, [`solc 0.5.7`](https://github.com/ethereum/solidity/tree/v0.5.7) and [`souffle 1.5.1`](https://github.com/souffle-lang/souffle/tree/1.5.1). You will also need libraries [`py-solc`](https://github.com/ethereum/py-solc) and [`graphviz`](https://gitlab.com/graphviz/graphviz/). We provide a dockerfile for an easy setup of the dependencies.
```
docker build . -t analyzer
docker run -it analyzer
```
You can follow the instructions in the dockerfile to install the dependencies locally.

## Example Usage

Try it out:
```
$ cd project
$ python analyze.py test_contracts/1.sol
Tainted
```

You can also inspect the contract’s control flow graph / Datalog representation:
```
$ python analyze.py --visualize test_contracts/1.sol
$ ls test_contract_out 
facts.pdf  graph.pdf
```
