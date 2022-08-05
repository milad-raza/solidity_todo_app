// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract TodoApp{

    struct TodoModel {
        uint _id;
        string todoText;
        bool isDeleted;
    }

    TodoModel[] private todos;

    mapping(uint256 => address) ownerTodos;

    function addTodo(string memory text) external {
        uint todoId = todos.length;
        todos.push(TodoModel(todoId, text, false));
        ownerTodos[todoId] = msg.sender;
    }

    function getTodos() public view returns (TodoModel[] memory) {
        TodoModel[] memory temp = new TodoModel[](todos.length);
        uint counter = 0;
        for(uint i = 0; i<todos.length; i++){
            if(ownerTodos[i] == msg.sender && !todos[i].isDeleted){
                temp[counter] = todos[i];
                counter++;
            }
        }
        
        TodoModel[] memory todoItems = new TodoModel[](counter);
        for(uint i = 0; i<counter; i++){
            todoItems[i] = temp[i];
        }

        return todoItems;
    }

    function deleteTodo(uint todoId) external{
        if(ownerTodos[todoId] == msg.sender && !todos[todoId].isDeleted){
            todos[todoId].isDeleted = true;
        }
    }

    function updateTodo(uint todoId, string memory updatedText) external {
        if(ownerTodos[todoId] == msg.sender && !todos[todoId].isDeleted){
            todos[todoId].todoText = updatedText;
        }
    }

    function deleteAllTodos() external{
        uint counter = 0;
        for(uint i = 0; i<todos.length; i++){
            if(ownerTodos[i] == msg.sender && !todos[i].isDeleted){
                todos[i].isDeleted = true;
                counter++;
            }
        }
    }   
}