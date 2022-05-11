module.exports = {
  networks: {
     development: {
//      host: "172.20.10.4",
    host:"192.168.168.43",// Localhost (default: none)
      port: 7545,            // Standard Ethereum port (default: none)
      network_id: "*",       // Any network (default: none)
     },
  },
    contracts_build_directory: "./src/artifacts/",

  // Configure your compilers
  compilers: {
    solc: {

       // See the solidity docs for advice
       // about optimization and evmVersion
        optimizer: {
          enabled: false,
          runs: 200
        },
        evmVersion: "byzantium"
    }
  }
};