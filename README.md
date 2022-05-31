---

Memo:

- Create new React app using latest dependencies:
```linux
npx create-next-app@latest --ts
```
- Create truffle project:

```linux
truffle init
```
- Uncomment development and compiler code in the truffle-config.js
```solidity
development: {
     host: "127.0.0.1",     // Localhost (default: none)
     port: 8545,            // Standard Ethereum port (default: none)
     network_id: "*",       // Any network (default: none)
    },
    
compilers: {
    solc: {
      version: "0.8.13",      // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      settings: {          // See the solidity docs for advice about optimization and evmVersion
       optimizer: {
         enabled: true,
         runs: 200
       },
       //evmVersion: "byzantium"
      }
    }
  },
  ```
  
  - Create a new smart contract TodoList.sol

```solidity
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract TodoList {
    string public name = "Todo List Yongchang He";
}
```

- Add TodoList  to `1_initial_migration.js` so that we can deploy TodoList.sol:

```solidity
const Migrations = artifacts.require("Migrations");
const TodoList = artifacts.require("TodoList");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(TodoList);
};
```
- Run `truffle compile` to compile smart contracts:

<img src=""
