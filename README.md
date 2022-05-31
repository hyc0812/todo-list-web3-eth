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

<img src="https://github.com/hyc0812/todo-list-web3-eth/blob/master/imgs/truffleCompile.png" width="600"/>

- Run `truffle migrate --reset` to deploy the contracts to local blockchain server hosted by Ganache:

<img src="https://github.com/hyc0812/todo-list-web3-eth/blob/master/imgs/truffleMigrateReset.png" width="600"/>

- Run truffle console to check previous work:

```linux
truffle console
```
- Using truffle console:
```linux
> todoListContract = await TodoList.deployed()
> todoListContract
```
```linux
> name = await todoListContract.name()
> name
```
`'Todo List Yongchang He'`

- Update smart contract TodoList.sol:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
contract TodoList {
    struct Task {
        uint id;
        string content;
        bool completed;
    }
    // define event
    event TaskCreated(uint id, string content, bool completed);
    event TaskToggled(uint id, bool completed);
    // define mapping
    mapping (address => mapping(uint => Task)) public tasks;
    mapping (address => uint) public tasksCount;
    // Initialize the contract
    constructor() {
        createTask("Hello World");
    }
    // Create a new task
    function createTask(string memory _content) public {
        uint taskCount = tasksCount[msg.sender];
        tasks[msg.sender][taskCount] = Task(taskCount, _content, false);
        emit TaskCreated(taskCount, _content, false);
        tasksCount[msg.sender]++;
    }
    // Toggle the completion of a task
    function toggleCompleted(uint _id) public {
        Task storage task = tasks[msg.sender][_id];
        task.completed = !task.completed;
        emit TaskToggled(_id, task.completed);
    }
}
```

<img src="https://github.com/hyc0812/todo-list-web3-eth/blob/master/imgs/mappingStructure.png" width="450"/>
<img src="https://github.com/hyc0812/todo-list-web3-eth/blob/master/imgs/mappingExplained.png" width="450"/>

- Deploy updated smart contract:

```linux
truffle compile
truffle migrate --reset
```
- Test deployment status again using `truffle console` (optional step):

```linux
> todoListContract = await TodoList.deployed()
> account = await web3.eth.getCoinbase()
> account
```
`'0x2ceb36a9581e1d8a997d4d181b09b31138174819'`
> account[0] of your ganache server

Get ETH balance of account[0]:
```linux
> web3.eth.getBalance(account)
```
`'99980299100000000000'`

tasksCount
```linux
> taskCount = await todoListContract.tasksCount(account)
> taskCount
```
`BN { negative: 0, words: [ 1, <1 empty item> ], length: 1, red: null }`
```linux
> taskCount.toNumber()
```
`1`

