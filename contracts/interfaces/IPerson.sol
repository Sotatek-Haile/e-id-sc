// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

interface IPerson {
    struct PersonInfo {
        string name;
        uint256 gender;
        uint256 age;
        uint256 score;
        bytes sensitiveInformation;
    }

    function changeManager(address newManager) external;
    function mint(address to, PersonInfo memory p) external;
    function edit(uint256 tokenId, PersonInfo memory p) external;
}
