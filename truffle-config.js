require('dotenv').config();
const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  networks: {
    testnet: {
      provider: () => new HDWalletProvider(process.env.PRIVATE_KEY, process.env.BSC_TESTNET_URL),
      network_id: "97",
      gas: 8000000,
      gasPrice: 20000000000,
      confirmations: 10,
      timeoutBlocks: 200,
      skipDryRun: true
    }
  },
  compilers: {
    solc: {
      version: "^0.8.0"
    }
  }
};
