// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
contract TodoList {
    struct Task {
        uint id;
        string content;
        bool completed;
    }
    event TaskCreated(uint id, string content, bool completed);
    event TaskCompleted(uint id, bool completed);
    mapping (address => mapping(uint => Task)) public tasks;
}