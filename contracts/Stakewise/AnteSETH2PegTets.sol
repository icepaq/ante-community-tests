// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../AnteTest.sol";
import "../interfaces/I1InchOracle.sol";

contract AnteSETH2PegTest is AnteTest("Ribbon Theta Vault Balance above or equal to asset value") {

    address constant private SETH2_ADDRESS = 0xFe2e637202056d30016725477c5da089Ab0A043A;
    I1InchOracle constant private ORACLE = I1InchOracle(0x07D91f5fb9Bf7798734C3f606dB065549F6893bb);

    uint256 public preCheckBlock = 0;
    uint256 public preCheckValue = 0;

    constructor() {
        protocolName = "Stakewise";
        testedContracts = [SETH2_ADDRESS];
    }

    function preCheck() external {
        preCheckBlock = block.number;
        preCheckValue = ORACLE.getRateToEth(SETH2_ADDRESS, false);
    }

    function checkTestPasses() public view override returns (bool) {
        if (preCheckBlock == 0 || preCheckValue == 0) {
            return true;
        }

        if (block.number - preCheckBlock < 10 || block.number - preCheckBlock > 120) return true;

        uint256 price = ORACLE.getRateToEth(SETH2_ADDRESS, false);
        bool test1 = (price * 100) / 1e18 > 95 && (price * 100) / 1e18 < 105;
        bool test2 = (preCheckValue * 100) / 1e18 > 95 && (preCheckValue * 100) / 1e18 < 105;

        // If one of these scenarios are true, returns true. If both are false, then return false.
        return test1 || test2;
    }
}
