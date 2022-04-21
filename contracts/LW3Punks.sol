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
    uint256 public tokenIds;
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

    function mint() public payable{
        require(tokenIds < maxTokenIds, "Maximum limit for minting NFT has reached");
        require(msg.value > _price, "Please transact with more Ether");
        tokenIds = tokenIds + 1;
        _mint(msg.sender, tokenIds);
    }

    // _baseURI overrides the openzeppelin implementation which by default returns
    // an empty string for the baseURI
    function _baseURI() internal view virtual override returns (string memory){
        return _baseTokenURI;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns( string memory){
        require(_exists(tokenId), "ERC721Metadata: Query for non-existant token");
        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json")): "";
    }

    function setPaused(bool val) public onlyOwner{
        _paused = val;
    }

    function transfer() public onlyOwner{
        uint256 balance = address(this).balance;
        address _owner = owner();
        (bool sent, ) = _owner.call{value:balance}("");
        require(sent,"Error transferring the balance. Please try again.");
    }

    receive() external payable {} //Gets called when msg.data no supplied
    fallback() external payable {} //Is called to recive ether when msg.data is defined
}


// LW3Punks Contract Address: 0xC3FD094df3322Ee0a9f8Ac76b0E8C0a45467509d