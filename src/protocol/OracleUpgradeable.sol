// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.20;

import { ITSwapPool } from "../interfaces/ITSwapPool.sol";
import { IPoolFactory } from "../interfaces/IPoolFactory.sol";
import { Initializable } from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract OracleUpgradeable is Initializable {
    address private s_poolFactory;
    // #q why have 2 almost identical functions __Oracle_init() and __Oracle_init_unchained()?
    // #answer this is a common Openzeppelin design for upgradeable contracts.
    //  unchained function(s, can be one or several) groups all the contructor logic at point of deployment into different functions dealing with different areas
    //  init function (usually just one) gathers all the contructor logic in one place and runs them, usually by just calling all the unchained functions
    //  https://forum.openzeppelin.com/t/difference-between-init-and-init-unchained/25255/2
    function __Oracle_init(address poolFactoryAddress) internal onlyInitializing {
        __Oracle_init_unchained(poolFactoryAddress);
    }

    function __Oracle_init_unchained(address poolFactoryAddress) internal onlyInitializing {
        // #audit missing zero address check
        s_poolFactory = poolFactoryAddress;
    }
    // #q why have 2 almost identical functions getPriceInWeth() and getPrice()?
    function getPriceInWeth(address token) public view returns (uint256) {
        // #e this function apparently returns price in wei, as indicated by the MockTSwapPool.sol code for getPriceOfOnePoolTokenInWeth().
        //  so 1 weth = 1e18
        // #audit potential reentrancy here bc getPool() and getPriceOfOnePoolTokenInWeth() are external calls to presumably TSWap contract(s) deployed somewhere onchain
        // #audit possible price manipulation or just simply bad/corrupted/inaccurate price data here?
        // #audit what happens when getPool() is called before s_poolFactory is initialized by __Oracle_init() or __Oracle_init_unchained()
        // #answer code for getPool() is not avail, but what we can be sure of is that this is an unknown outcome that can be potentially disastrous
        // #audit was this tested with forked tests? if this was just tested with mocks like the tests suggest, the tests are potentially inadequate
        address swapPoolOfToken = IPoolFactory(s_poolFactory).getPool(token);
        return ITSwapPool(swapPoolOfToken).getPriceOfOnePoolTokenInWeth();
    }

    function getPrice(address token) external view returns (uint256) {
        return getPriceInWeth(token);
    }

    function getPoolFactoryAddress() external view returns (address) {
        return s_poolFactory;
    }
}
