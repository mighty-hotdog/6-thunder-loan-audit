// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.20;

interface ITSwapPool {
    // #e this function apparently returns price in wei, as indicated by the MockTSwapPool.sol code for getPriceOfOnePoolTokenInWeth().
    //  so 1 weth = 1e18
    function getPriceOfOnePoolTokenInWeth() external view returns (uint256);
}
