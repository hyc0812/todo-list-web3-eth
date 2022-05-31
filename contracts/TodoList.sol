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