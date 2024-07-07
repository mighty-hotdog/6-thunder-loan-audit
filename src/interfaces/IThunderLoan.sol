// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// #audit this interface, presumably for the ThunderLoan contract, is not implemented at all
interface IThunderLoan {
    // #audit this function interface is different vs the one in ThunderLoan contract
    //  this function takes in an address input, while the one in ThunderLoan contract takes in an IERC20 input
    function repay(address token, uint256 amount) external;
}
