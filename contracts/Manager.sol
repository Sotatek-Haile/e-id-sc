// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "./interfaces/IManager.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract Manager is OwnableUpgradeable {

    function initialize() public initializer {
        __Ownable_init();
    }

}
