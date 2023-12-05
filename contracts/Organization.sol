// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "./interfaces/IOrganization.sol";
import "./interfaces/IManager.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";

contract Organization is IOrganization, ERC721Upgradeable {

    uint256 public latestIndex;
    address public managerAddress;
    mapping(uint256 => OrganizationInfo) public organizationInfo;

    event ManagerChange(address newManager);
    event NewOrganization(OrganizationInfo newPerson, address owner, uint256 tokenId);
    event EditOrganization(OrganizationInfo newPerson, address owner, uint256 tokenId);

    modifier onlyOwner {
        require(msg.sender == IManager(managerAddress).owner(), "Invalid sender");
        _;
    }

    function initialize(
        string memory _name,
        string memory _symbol,
        address _managerAddress
    ) public initializer {
        __ERC721_init(_name, _symbol);
        managerAddress = _managerAddress;
    }

    function changeManager(address newManager) public onlyOwner {
        managerAddress = newManager;
        emit ManagerChange(newManager);
    }

    function mint(address to, OrganizationInfo memory p) public onlyOwner {
        latestIndex++;
        organizationInfo[latestIndex] = p;
        _mint(to, latestIndex);
        emit NewOrganization(p, to, latestIndex);
    }

    function edit(uint256 tokenId, OrganizationInfo memory p) public onlyOwner {
        organizationInfo[tokenId] = p;
        address owner = ownerOf(tokenId);
        emit EditOrganization(p, owner, tokenId);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "http://localhost:3000/organization/";
    }

}
