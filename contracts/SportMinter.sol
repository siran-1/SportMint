// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract SportMinter is ERC721, Ownable {
    using Strings for uint256;

    uint256 private _tokenIdCounter;
    string private _baseTokenURI;
    mapping(uint256 => string) private _tokenURIs;

    constructor() ERC721("MyNFT", "MNFT") Ownable(msg.sender) {
        _tokenIdCounter = 0;
    }

    function safeMint(address to, uint256 tokenId) public onlyOwner {
    require(!_exists(tokenId), "Token ID already exists");

    _mint(to, tokenId); // Mint the token
    string memory metadataURI = string(abi.encodePacked(_baseTokenURI, "/", tokenId.toString(), ".json"));
    _setTokenURI(tokenId, metadataURI); 
    }


    function setBaseURI(string memory baseURI) public onlyOwner {
        _baseTokenURI = baseURI;
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return string(abi.encodePacked(_baseTokenURI, "/", tokenId.toString(), ".json"));
    }

    function _setTokenURI(uint256 tokenId, string memory uri) internal {
        _tokenURIs[tokenId] = uri;
    }

    function _exists(uint256 tokenId) internal view returns (bool) {
        return bytes(_tokenURIs[tokenId]).length > 0;
    }
    // Event to log the sale of an NFT
    event NFTSold(uint256 tokenId, address from, address to, uint256 value);
}
