// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract TasksContract {
    uint public taskCounter = 0;
    struct Task {
        uint id;
        string title;
        string description;
        bool done;
        uint createdAt;
    }

    mapping(uint256 => Task) public tasks;

    constructor() {
        createTask("Primer tarea de ejemplo", "hacer algo");
    }

    event TaskCreated(
        uint id,
        string title,
        string description,
        bool done,
        uint createdAt
    );

    event TaskToogleDone(uint id, bool done);

    function createTask(
        string memory _title,
        string memory _description
    ) public {
        tasks[taskCounter] = Task(
            taskCounter,
            _title,
            _description,
            false,
            block.timestamp
        );
        taskCounter++;
        emit TaskCreated(
            taskCounter,
            _title,
            _description,
            false,
            block.timestamp
        );
    }

    function toogleDone(uint _id) public {
        Task memory _task = tasks[_id];
        _task.done = !_task.done;
        tasks[_id] = _task;
        emit TaskToogleDone(_id, _task.done);
    }
}
