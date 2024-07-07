// SPDX-License-Identifier: AGPL-3.0
pragma solidity 0.8.20;
// #audit unused import
//  well actually, this is being "imported-by-proxy" in MockFlashLoanReceiver.sol.
//  bad practice to modify production code for testing, better to just import directly in MockFlashLoanReceiver.sol
import { IThunderLoan } from "./IThunderLoan.sol";

/**
 * @dev Inspired by Aave:
 * https://github.com/aave/aave-v3-core/blob/master/contracts/flashloan/interfaces/IFlashLoanReceiver.sol
 */
// #q what operation? giving out a loan?
interface IFlashLoanReceiver {
    function executeOperation(
        address token,
        uint256 amount,
        uint256 fee,
        address initiator,
        bytes calldata params
    )
        external
        returns (bool);
}
