// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";


contract ExempleNFT is ERC721Enumerable, ERC721URIStorage, AccessControl {
    
    using Counters for Counters.Counter;
    using Strings for uint256; 

    enum Genre {
        Man,
        Women
    }

    struct People {
        Genre genre;
        uint256 nftId;
        uint256 age;
        uint256 favNumber;
        string name;
    }

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    Counters.Counter private _peopleId;
    mapping(uint256 => People) private _peoples;

    constructor() ERC721("PoepleNFT", "PLN") {
        _setupRole(MINTER_ROLE, msg.sender);
    }

    function createNftPoeple(
        address sender,
        Genre genre,
        uint256 age,
        uint256 favNumber,
        uint256 nftId,
        string memory name_
    ) public onlyRole(MINTER_ROLE) returns (uint256) {
        _peopleId.increment();
        uint256 currentId = _peopleId.current();
        _mint(sender, currentId);
        _setTokenURI(currentId, nftId.toString());
        _peoples[currentId] = People(genre, age, favNumber, nftId, name_);
        return currentId;
    }

    function getPeopleById(uint256 id) public view returns (People memory) {
        return _peoples[id];
    }

    function tokenURI(uint256 tokenId) public view virtual override(ERC721URIStorage, ERC721) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function _baseURI() internal view virtual override(ERC721) returns (string memory) {
        return "https://www.poeple-are-nft.com/nft/";
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721Enumerable, ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    )  internal virtual override(ERC721Enumerable, ERC721) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal virtual override(ERC721URIStorage, ERC721) {
        super._burn(tokenId);
    }
}