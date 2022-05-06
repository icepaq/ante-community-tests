// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface I1InchOracle {
  function getRateToEth(address srcToken, bool isWrapper) external view returns (uint256);
}