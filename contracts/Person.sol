// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "./interfaces/IPerson.sol";
import "./interfaces/IManager.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";

contract Person is IPerson, ERC721Upgradeable {

    uint256 public latestIndex;
    address public managerAddress;
    mapping(uint256 => PersonInfo) public personInfo;

    event ManagerChange(address newManager);
    event NewPerson(PersonInfo newPerson, address owner, uint256 tokenId);
    event EditPerson(PersonInfo newPerson, address owner, uint256 tokenId);
    event ScoreChange(address owner, uint256 tokenId, uint256 sId, uint256 score);

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

    function mint(address to, PersonInfo memory p) public onlyOwner {
        latestIndex++;
        personInfo[latestIndex] = p;
        _mint(to, latestIndex);
        emit NewPerson(p, to, latestIndex);
    }

    function edit(uint256 tokenId, PersonInfo memory p) public onlyOwner {
        personInfo[tokenId] = p;
        address owner = ownerOf(tokenId);
        emit EditPerson(p, owner, tokenId);
    }

    function addScore(uint256 tokenId, uint256 sId, uint256 score) public onlyOwner {
        PersonInfo storage p = personInfo[tokenId];
        p.score += score;
        address owner = ownerOf(tokenId);
        emit ScoreChange(owner, tokenId, sId, p.score);
    }

    function subtractScore(uint256 tokenId, uint256 sId, uint256 score) public onlyOwner {
        PersonInfo storage p = personInfo[tokenId];
        p.score -= score;
        address owner = ownerOf(tokenId);
        emit ScoreChange(owner, tokenId, sId, p.score);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override {
        require(from == address(0), "Cannot transfer");
        require(balanceOf(to) == 0, "Each user must have 1 NFT");
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "http://localhost:3000/person/";
    }

}
