# Solidity implementation for finding non-zero byte length of a uint256 using binary search

## Rationale

Compare with linear search implementation

## Pre-requisites

 - [Foundry](https://book.getfoundry.sh/getting-started/installation)

## Test

`forge test`

## Gas test results

Profiled with `forge test`

|            number            | binary search gas cost | linear search gas cost |
|------------------------------|------------------------|------------------------|
| 1                            | 8933                   | 11060                  |
| 10                           | 8899                   | 11006                  |
| 100                          | 8922                   | 11017                  |
| 1000                         | 8899                   | 10952                  |
| 10000                        | 8866                   | 10997                  |
| 100000                       | 8921                   | 10836                  |
| 10 ** 18                     | 8878                   | 10434                  |
| 10 ** 40                     | 8854                   | 9645                   |
| (2 ** 256) - 1               | 8812                   | 8373                   |
