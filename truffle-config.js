var HDWalletProvider = require("truffle-hdwallet-provider");
var mnemonic = "YOUR-MNEMONCI-KEY-GOES-HERE";

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*"
    },
    rinkeby: {
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://rinkeby.infura.io/v3/YOUR-API-KEY-GOES-HERE")
      },
      network_id: 4
    },
    ropsten: {
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://ropsten.infura.io/v3/YOUR-API-KEY-GOES-HERE")
      },
      network_id: 3
    }

  },
  compilers: {
    solc: {
      version: "0.4.24"
    }
  }
};