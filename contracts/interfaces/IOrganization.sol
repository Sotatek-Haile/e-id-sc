// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

interface IOrganization {
    struct OrganizationInfo {
        string name;
        string taxCode;
    }
    function changeManager(address newManager) external;
    function mint(address to, OrganizationInfo memory p) external;
    function edit(uint256 tokenId, OrganizationInfo memory p) external;
}
