const ERC721 = artifacts.require("ERC721");

module.exports = function(deployer) {
  deployer.deploy(ERC721, "TokenName", "SYMBOL", 1000);
};