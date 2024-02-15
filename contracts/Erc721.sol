// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

/**
 * ERC721 Smart Contract
 */
contract ERC721 {
    string public tokenName;
    string public symbol;
    uint256 public totalSupply;

    mapping(uint256 => address) public tokenOwners;
    mapping(address => uint256[]) public tokensOwnedBy;

    address public owner;

    constructor(string memory _tokenName, string memory _symbol, uint256 _totalSupply) {
        tokenName = _tokenName;
        symbol = _symbol;
        totalSupply = _totalSupply;
        owner = msg.sender; 
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function mint(address _to, uint256 _tokenId) public onlyOwner {
        require(_tokenId > 0 && _tokenId <= totalSupply, "Invalid token ID");
        require(tokenOwners[_tokenId] == address(0), "Token already minted");

        tokenOwners[_tokenId] = _to;
        tokensOwnedBy[_to].push(_tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        require(msg.sender == _from || msg.sender == owner, "You are not authorized to transfer this token");
        require(_to != address(0), "Invalid recipient address");
        require(tokenOwners[_tokenId] == _from, "Token is not owned by the sender");

        tokenOwners[_tokenId] = _to;
    }

    function listOfTokenIds(address _person) public view returns (uint256[] memory) {
        return tokensOwnedBy[_person];
    }

    // Function to perform bulk transfer of NFTs
    function bulkTransfer(address[] memory _recipients, uint256[] memory _tokenIds) public {
        require(_recipients.length == _tokenIds.length, "Arrays length mismatch");

        for (uint256 i = 0; i < _recipients.length; i++) {
            transferFrom(msg.sender, _recipients[i], _tokenIds[i]);
        }
    }
}
