//SPDX-License-Identifier: None
//FROM https://github.com/0xngmi/llamapay/blob/78bf25ebabf16365b65e85b3818c4df12a228b1a/contracts/LlamaPayFactory.sol
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./LlamaPay.sol";

contract LlamaPayFactory is Ownable {
    mapping(address => address) public payContracts;
    mapping(uint256 => address) public payContractsArray;
    uint256 public payContractsArrayLength;

    event LlamaPayCreated(address token, address llamaPay);

    function createPayContract(address _token) external returns (address newContract) {
        require(payContracts[_token] == address(0), "already exists");
        newContract = address(new LlamaPay(_token, address(this)));
        payContracts[_token] = newContract;
        payContractsArray[payContractsArrayLength] = newContract;
        unchecked {
            payContractsArrayLength++;
        }
        emit LlamaPayCreated(_token, address(newContract));
    }
}
