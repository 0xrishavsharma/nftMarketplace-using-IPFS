// SPDX-License-Identifier: MIT

pragma solidity^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract LW3Punks is ERC721Enumerable, Ownable{
    using Strings for uint256;
    string _baseTokenURI;
    uint256 public _price = 0.01 ether;
    uint256 public maxTokenIds = 10;
    uint256 public totalIds;
    bool public _paused;
    
    /* @dev checking if the contract is already paused or not */
    modifier onlyWhenNotPaused {
        require(!_paused, "Auction is already stopped!");
        _;
    }

    /* @dev ERC721 constructor expects name of the token and symbol */
    // LW3P takes in baseURI to set _baseTokenURI for the collection
    constructor(string memory baseURI) ERC721("LW3Punks", "LW3P"){
        _baseTokenURI = baseURI;
    }
}