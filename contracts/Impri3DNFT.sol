// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";


contract Impri3DNFT is ERC721Enumerable, ERC721URIStorage, AccessControl {

    using Counters for Counters.Counter;
    using Strings for uint256; 

    string private _name;
    string private _symbol;

    struct Order {
        string refProduit;
        uint256 quantities;
        address refMark;
        // uint256 dates;
    }

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    Counters.Counter private _orderIds;
    mapping(uint256 => Order) private _orders;

    constructor(string memory name_, string memory symbol_, address minterRole) ERC721(_name, _symbol) {
        _name = name_;
        _symbol = symbol_;
        _setupRole(MINTER_ROLE, minterRole);
    }

     function order(
         address refMarque,
        string memory refProduct,
        uint256 quantite
    ) public onlyRole(MINTER_ROLE) returns (uint256) {
        _orderIds.increment();
        uint256 currentId = _orderIds.current();
        _mint(refMarque, currentId);
        _setTokenURI(currentId, currentId.toString());
        _orders[currentId] = Order(refProduct, quantite, refMarque);
        return currentId;
    }

    function getLootById(uint256 id) public view returns (Order memory) {
        return _orders[id];
    }

    function tokenURI(uint256 tokenId) public view virtual override(ERC721URIStorage, ERC721) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function _baseURI() internal view virtual override(ERC721) returns (string memory) {
        return "https://www.magnetgame.com/nft/";
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
