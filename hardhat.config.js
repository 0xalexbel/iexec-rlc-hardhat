require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-foundry");

/** @type import('hardhat/config').HardhatUserConfig */
// module.exports = {
//   solidity: "0.8.24",
//   evmVersion: "cancun",
// };

module.exports = {
  solidity: {
    version: "0.4.11",
    settings: {
      optimizer: {
        enabled: true,
        runs: 1000,
      },
    },
  },
};
